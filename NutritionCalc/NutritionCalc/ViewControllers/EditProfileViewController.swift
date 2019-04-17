//
//  EditProfileViewController.swift
//  NutritionCalc
//
//  Created by Zach on 4/10/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

   
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
        let age = AgeTextField.text
        let sex = SexSegControl.selectedSegmentIndex
        let feet = HeightFeetTextField.text
        let inches = HeightInchesTextField.text
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
