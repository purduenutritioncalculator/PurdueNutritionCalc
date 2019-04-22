//
//  EditProfileViewController.swift
//  NutritionCalc
//
//  Created by Zach on 4/10/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    var sex = 1
    var height = 0
    var weight = 0
    var age = 0
    var cals = 0.0
    var protein = 0.0
    var fat = 0.0
    var carb = 0.0
   
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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
    }
    
    @IBAction func OnBMITap(_ sender: Any) {
        if(AgeTextField.text == "" || HeightInchesTextField.text == "" || HeightFeetTextField.text == "") {
            let errorMsg = "Please fill the Sex, Age and Height categories for recommended BMI stats"
            let errorAlert = UIAlertController(title: "Empty Fields", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(errorAlert, animated: true, completion: nil)
            return
        }
        age = Int(AgeTextField.text!) ?? 0
        sex = SexSegControl.selectedSegmentIndex
        let feet = Int(HeightFeetTextField.text!) ?? 6
        let inches = Int(HeightInchesTextField.text!) ?? 0
        let totInches = feet * 12 + inches
        let cals = Double(caloriesTextField.text!) ?? 2000
        let fatPct = (Double(FatsTextField.text!) ?? 20) / 100
        let carbPct = (Double(CarbsTextField.text!) ?? 50) / 100
        let proteinPct = (Double(ProteinTextField.text!) ?? 30) / 100
        
        fat = cals * fatPct
        protein = cals * proteinPct
        carb = cals * carbPct
    }
    
    @IBAction func onSubmitStats(_ sender: Any) {
        
    }
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
