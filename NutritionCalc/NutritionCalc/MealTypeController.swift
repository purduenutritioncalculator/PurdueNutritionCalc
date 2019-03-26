//
//  MealTypeController.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 3/22/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class MealTypeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mealSelectTableView: UITableView!
    
    var mealTypes = ["Breakfast", "Lunch", "Dinner"]
    var diningCourt = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mealSelectTableView.delegate = self
        mealSelectTableView.dataSource = self
        
        mealSelectTableView.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealSelectCell") as! MealSelectCell
        cell.mealTypeLabel.text = mealTypes[indexPath.row]
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = mealSelectTableView.indexPath(for: cell)!
        let mealType = mealTypes[indexPath.row]
        let menuViewController = segue.destination as! MenuViewController
        
        menuViewController.name = diningCourt
        menuViewController.mealType = mealType
    }
}
