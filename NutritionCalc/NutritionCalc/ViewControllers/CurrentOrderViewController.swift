//
//  CurrentOrderViewController.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/8/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class CurrentOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myOrder:UserMeal = UserMeal()

    @IBOutlet weak var currentOrderTableView: UITableView!
    @IBOutlet weak var totalCalLabel: UILabel!
    @IBOutlet weak var totalProteinLabel: UILabel!
    @IBOutlet weak var totalFatLabel: UILabel!
    @IBOutlet weak var totalCarbsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentOrderTableView.dataSource = self
        currentOrderTableView.delegate = self
        
        currentOrderTableView.estimatedRowHeight = 125
        currentOrderTableView.rowHeight = UITableView.automaticDimension
        
        self.title = "Current Order"
        
        totalCalLabel.text = "\(myOrder.calories)"
        totalFatLabel.text = "\(myOrder.fat)g"
        totalCarbsLabel.text = "\(myOrder.carbs)g"
        totalProteinLabel.text = "\(myOrder.protein)g"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (myOrder.foods.count > 0) {
            return myOrder.foods.count
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentOrderItem") as! CurrentOrderCell
        
        
        if (myOrder.foods.count > 0) {
            
            cell.nutritionDesc.isHidden = false
            cell.quantityField.isHidden = false
            cell.addQuantityButton.isHidden = false
            cell.subtractQuantityButton.isHidden = false
            cell.servingsLabel.isHidden = false
            
            cell.itemNameLabel.text = myOrder.foods[indexPath.row].Name
            cell.quantityField.text = "1"
            
            let calories = findLabelValOfType(type: "Calories", food: myOrder.foods[indexPath.row], index: indexPath.row)
            let protein = findLabelValOfType(type: "Protein", food: myOrder.foods[indexPath.row], index: indexPath.row)
            let fat = findLabelValOfType(type: "Total fat", food: myOrder.foods[indexPath.row], index: indexPath.row)
            let carbs = findLabelValOfType(type: "Total Carbohydrate", food: myOrder.foods[indexPath.row], index: indexPath.row)
            
            let descString = "Per serving nutrition:\nCalories: \(calories)\nProtein: \(protein)\nFat: \(fat)\nCarbs: \(carbs)"
            
            cell.nutritionDesc.text = descString
            
            return cell
        } else {
            
            cell.itemNameLabel.text = "No Items Added"
            cell.nutritionDesc.isHidden = true
            cell.quantityField.isHidden = true
            cell.addQuantityButton.isHidden = true
            cell.subtractQuantityButton.isHidden = true
            cell.servingsLabel.isHidden = true
            
            return cell
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let dest = segue.destination as? HomeScreenViewController {
            dest.mealList.append(myOrder)
            let newSavedMeal = MealModel(context: PersistenceService.context)
            newSavedMeal.calories = Int16(myOrder.calories)
            newSavedMeal.carbs = Int16(myOrder.carbs)
            newSavedMeal.fats = Int16(myOrder.fat)
            newSavedMeal.protein = Int16(myOrder.protein)
            newSavedMeal.date = myOrder.date as NSDate
            dest.savedMeals.append(newSavedMeal)
            PersistenceService.saveContext()
        }
        
    }
 
    
    func findLabelValOfType(type: String, food: ItemDetail, index: Int) -> String {
        for entry in food.Nutrition {
            if entry.Name == type {
                return entry.LabelValue
            }
        }
        
        return "Unspecified"
    }

}
