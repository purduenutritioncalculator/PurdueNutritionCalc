//
//  HomeScreenViewController.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/1/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

    @IBAction func startOrder(_ sender: Any) {
        performSegue(withIdentifier: "beginOrder", sender: self)
    }
}
