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
    
    @IBOutlet weak var CaloriesTextField: UITextField!
    
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
    
    
    @IBAction func OnBMITap(_ sender: Any) {
        
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
