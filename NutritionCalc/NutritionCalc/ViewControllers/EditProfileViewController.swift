//
//  EditProfileViewController.swift
//  NutritionCalc
//
//  Created by Zach on 4/10/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var sexG = 1
    var heightFeetG = 0.0
    var weightG = 0
    var ageG = 0
    var calsG = 0.0
    var proteinG = 0.0
    var fatG = 0.0
    var carbG = 0.0
    
    @IBOutlet weak var HeightFeetTextField: UITextField!
    
    @IBOutlet weak var HeightInchesTextField: UITextField!
    
    
    @IBOutlet weak var SexSegControl: UISegmentedControl!
    
    @IBOutlet weak var AgeTextField: UITextField!
    
    @IBOutlet weak var WeightTextField: UITextField!
    
    @IBOutlet weak var caloriesTextField: UITextField!
    
    
    @IBOutlet weak var ProteinTextField: UITextField!
    
    @IBOutlet weak var CarbsTextField: UITextField!
    
    @IBOutlet weak var FatsTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if FatsTextField.isEditing {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        if let age = Int(AgeTextField.text!), let feet = Int(HeightFeetTextField.text!), let inches = Double(HeightInchesTextField.text!), let weight = Double(WeightTextField.text!), let calories = Int(caloriesTextField.text!), let protein = Int(ProteinTextField.text!), let fat = Int(FatsTextField.text!), let carbs = Int(CarbsTextField.text!) {
            let decoder = PropertyListDecoder()
            if let currentInfo = try? decoder.decode(User.self, from: (UserDefaults.standard.value(forKey: "UserInfo") as? Data)!) {
                let name = currentInfo.name
                let sex = SexSegControl.selectedSegmentIndex
                let newUser = User(name: name, sex: sex, age: age, feet: feet, inches: inches, weight: weight, calories: calories, protein: protein, fat: fat, carbs: carbs)
                let encoder = PropertyListEncoder()
                
                if let data = try? encoder.encode(newUser) as Data {
                    UserDefaults.standard.set(data, forKey: "UserInfo")
                    print("about to return!")
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
            }
        }
        
        else {
            let errorMsg = "Please fill all fields before submitting"
            let errorAlert = UIAlertController(title: "Empty Fields", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(errorAlert, animated: true, completion: nil)
            return
        }
        
        
        
    }
    
    @IBAction func OnBMITap(_ sender: Any) {
        let age = Double(AgeTextField.text!) ?? 0
        let weight = Double(WeightTextField.text!) ?? 150
        let sexSelection = SexSegControl.selectedSegmentIndex
        let feet = Double(HeightFeetTextField.text!) ?? 6
        let inches = Double(HeightInchesTextField.text!) ?? 0
        let totInches = feet * 12 + inches
        let cals = Double(caloriesTextField.text!) ?? 2000
        let fatPct = (Double(FatsTextField.text!) ?? 20) / 100
        let carbPct = (Double(CarbsTextField.text!) ?? 50) / 100
        let proteinPct = (Double(ProteinTextField.text!) ?? 30) / 100
        fatG = cals * fatPct
        proteinG = cals * proteinPct
        carbG = cals * carbPct
        if(AgeTextField.text == "" || HeightInchesTextField.text == "" || HeightFeetTextField.text == "") {
            let errorMsg = "Please fill the Sex, Age and Height categories for recommended BMI stats"
            let errorAlert = UIAlertController(title: "Empty Fields", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(errorAlert, animated: true, completion: nil)
        }else {
            var BMR = 0.0
            if(SexSegControl.selectedSegmentIndex == 0){
                BMR = 66.0
                BMR += (6.23 * weight)
                BMR += ((12.7 * totInches) - (6.8 * age))
            }
            else{
                BMR = (665.0 + (4.35 * weight))
                BMR += (12.7 * totInches) - (6.8 * age)
            }
            let caloriesNeeded = Int(BMR * 1.55)
            caloriesTextField.text = String.init(format: "%d", caloriesNeeded)
            
            let kilos = Double(weight) * 0.453592
            let proteinRec = Int(0.8 * kilos)
            ProteinTextField.text = "\(proteinRec)"
            let carbRec = Int(Double(caloriesNeeded) * 0.55 / 4.0)
            CarbsTextField.text = "\(carbRec)"
            let fatRec = Int(Double(caloriesNeeded) * 0.3 / 9.0)
            FatsTextField.text = "\(fatRec)"
            return
        }
        
        
    }
    
    @IBAction func onSubmitStats(_ sender: Any) {
        let cals = Double(caloriesTextField.text!) ?? 2000
        let fatPct = (Double(FatsTextField.text!) ?? 20) / 100
        let carbPct = (Double(CarbsTextField.text!) ?? 50) / 100
        let proteinPct = (Double(ProteinTextField.text!) ?? 30) / 100
        fatG = calsG * fatPct / 9
        proteinG = calsG * proteinPct / 4
        carbG = calsG * carbPct / 4
        
    }
    
    @IBAction func exitKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    @IBAction func clearAllData(_ sender: Any) {
        // an alert with the following message will pop up asking user if they are sure they want to clear infos
        let clearMessage = "Are you sure you want to clear all app data? All entered information will be lost and you will be returned to the login screen. This action cannot be undone."
        let clearAlert = UIAlertController(title: "Clear Data", message: clearMessage, preferredStyle: UIAlertController.Style.alert)
        
        // if the user confirms clearing data, will call confirmedClear() method
        clearAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction)
            in self.confirmedClear()
        }))
        
        // if the user says they don't want to clear data, print they cancelled to console
        clearAlert.addAction(UIAlertAction(title: "No", style: .default, handler: {
            (action: UIAlertAction) in
            print("user cancelled the clear data")
        }))
        
        // present the alert
        present(clearAlert, animated: true, completion: nil)
    }
    
    func confirmedClear() {
        // set the courses array to a blank array
        UserDefaults.standard.set(nil, forKey: "UserInfo")
        
        // take user back to login screen
        //self.performSegue(withIdentifier: "clearedData", sender: self)
        let registrationStoryBoard = UIStoryboard(name: "Register", bundle: nil)
        let VC = registrationStoryBoard.instantiateInitialViewController()
        let mainWindow = UIApplication.shared.delegate?.window
        mainWindow!!.rootViewController = VC
        mainWindow!!.makeKeyAndVisible()
    }
}
*/
