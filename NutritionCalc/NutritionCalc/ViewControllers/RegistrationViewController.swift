//
//  RegistrationViewController.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/17/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var sexSelector: UISegmentedControl!
    @IBOutlet weak var feetField: UITextField!
    @IBOutlet weak var inchesField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var calorieField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var proteinField: UITextField!
    @IBOutlet weak var carbField: UITextField!
    
    @IBOutlet weak var autofillErrorLabel: UILabel!
    @IBOutlet weak var registrationErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        autofillErrorLabel.isHidden = true
        registrationErrorLabel.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if nameField.isEditing || ageField.isEditing || feetField.isEditing || inchesField.isEditing {
            return
        }
        else {
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
    
    @IBAction func exitKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func register(_ sender: Any) {
        if let name = nameField.text, !name.isEmpty,
            let age = Int(ageField.text!), let feet = Int(feetField.text!),
            let inches = Double(inchesField.text!),
            let weight = Double(weightField.text!),
            let calories = Int(calorieField.text!),
            let fats = Int(fatField.text!),
            let protein = Int(proteinField.text!),
            let carbs = Int(carbField.text!) {
            
            let encoder = PropertyListEncoder()
            let sex = sexSelector.selectedSegmentIndex
            let newUser = User(name: name, sex: sex, age: age, feet: feet, inches: inches, weight: weight, calories: calories, protein: protein, fat: fats, carbs: carbs)
            
            if let userData = try? encoder.encode(newUser) as Data {
                UserDefaults.standard.set(userData, forKey: "UserInfo")
            }
            
            registrationErrorLabel.isHidden = true
            self.performSegue(withIdentifier: "register", sender: self)
        }
        else {
            registrationErrorLabel.isHidden = false
        }
    }
    
    @IBAction func autoFill(_ sender: Any) {
        if let name = nameField.text, !name.isEmpty,
            let age = Int(ageField.text!), let feet = Int(feetField.text!),
            let inches = Double(inchesField.text!),
            let weight = Double(weightField.text!) {
            
            var BMR = 0.0
            if(sexSelector.selectedSegmentIndex == 0){
                BMR = 66.0
                BMR += (6.23 * weight)
                var totInches = Double(feet) * 12.0 + inches
                BMR += ((12.7 * totInches) - (6.8 * Double(age)))
            }
            else{
                BMR = (665.0 + (4.35 * weight))
                var totInches = Double(feet) * 12.0 + inches
                BMR += (12.7 * totInches) - (6.8 * Double(age))
            }
            
            let caloriesNeeded = Int(BMR * 1.55)
            calorieField.text = String.init(format: "%d", caloriesNeeded)
            
            let kilos = weight * 0.453592
            let proteinRec = Int(kilos * 0.8)
            proteinField.text = "\(proteinRec)"
            let carbRec = Int(Double(caloriesNeeded) * 0.55 / 4.0)
            carbField.text = "\(carbRec)"
            let fatRec = Int(Double(caloriesNeeded) * 0.3 / 9.0)
            fatField.text = "\(fatRec)"
            autofillErrorLabel.isHidden = true
            
        }
        else {
            autofillErrorLabel.isHidden = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
