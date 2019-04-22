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
        currentOrderTableView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)

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
        cell.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 0.0)
        
        
        if (myOrder.foods.count > 0) {
            
            cell.nutritionDesc.isHidden = false
            cell.quantityField.isHidden = false
            cell.addQuantityButton.isHidden = false
            cell.subtractQuantityButton.isHidden = false
            cell.servingsLabel.isHidden = false
            
            cell.itemNameLabel.text = myOrder.foods[indexPath.row].Name
            cell.quantityField.text = String(myOrder.quantities[indexPath.row])
            
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if myOrder.quantities.count > 1 {
                editNutrition(quantity: -1 * myOrder.quantities[indexPath.row], item: myOrder.foods[indexPath.row])
                
                myOrder.foods.remove(at: indexPath.row)
                myOrder.quantities.remove(at: indexPath.row)
                
                currentOrderTableView.deleteRows(at: [indexPath], with: .automatic)
                
                totalCalLabel.text = "\(myOrder.calories)"
                totalFatLabel.text = "\(myOrder.fat)g"
                totalCarbsLabel.text = "\(myOrder.carbs)g"
                totalProteinLabel.text = "\(myOrder.protein)g"
            }
            else {
                editNutrition(quantity: -1 * myOrder.quantities[indexPath.row], item: myOrder.foods[indexPath.row])
                myOrder.foods.remove(at: indexPath.row)
                myOrder.quantities.remove(at: indexPath.row)
                
                currentOrderTableView.reloadData()
                totalCalLabel.text = "\(myOrder.calories)"
                totalFatLabel.text = "\(myOrder.fat)g"
                totalCarbsLabel.text = "\(myOrder.carbs)g"
                totalProteinLabel.text = "\(myOrder.protein)g"
            }
            
            
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "submitMeal" {
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
        else if segue.identifier == "backToItemList" {
            if let dest = segue.destination as? MenuViewController {
                dest.userMeal = self.myOrder
            }
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

    @IBAction func increaseQuantity(_ sender: Any) {
        
        let incrButton = sender as! UIButton
        
        var superview = incrButton.superview
        
        while !(superview is UITableViewCell) {
            superview = superview?.superview
        }
        
        let sendingCell = superview as! CurrentOrderCell
        var currentQuantity = Int(sendingCell.quantityField.text!)!
        currentQuantity = currentQuantity + 1
        sendingCell.quantityField.text = "\(currentQuantity)"
        
        if let index = currentOrderTableView.indexPath(for: sendingCell) {
            myOrder.quantities[index.row] += 1
            editNutrition(quantity: 1, item: myOrder.foods[index.row])
            totalCalLabel.text = "\(myOrder.calories)"
            totalFatLabel.text = "\(myOrder.fat)g"
            totalCarbsLabel.text = "\(myOrder.carbs)g"
            totalProteinLabel.text = "\(myOrder.protein)g"
        }
        
    }
    
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        
        let incrButton = sender as! UIButton
        
        var superview = incrButton.superview
        
        while !(superview is UITableViewCell) {
            superview = superview?.superview
        }
        
        let sendingCell = superview as! CurrentOrderCell
        var currentQuantity = Int(sendingCell.quantityField.text!)!
        if currentQuantity > 1 {
            currentQuantity = currentQuantity - 1
            sendingCell.quantityField.text = "\(currentQuantity)"
        }
        else {
            return
        }
        
        if let index = currentOrderTableView.indexPath(for: sendingCell) {
            myOrder.quantities[index.row] -= 1
            editNutrition(quantity: -1, item: myOrder.foods[index.row])
            totalCalLabel.text = "\(myOrder.calories)"
            totalFatLabel.text = "\(myOrder.fat)g"
            totalCarbsLabel.text = "\(myOrder.carbs)g"
            totalProteinLabel.text = "\(myOrder.protein)g"
        }
        
    }
    
    func editNutrition(quantity: Int, item: ItemDetail) {
        var calories = 0
        var fat = 0
        var carbs = 0
        var protein = 0
        
        for entry in item.Nutrition {
            if entry.Name == "Calories" {
                let val = Int(entry.LabelValue.filter("01234567890.".contains)) ?? 0
                calories = val
            } else if entry.Name == "Total Carbohydrate" {
                let val = Int(entry.LabelValue.filter("01234567890.".contains)) ?? 0
                carbs = val
            } else if entry.Name == "Protein" {
                let val = Int(entry.LabelValue.filter("01234567890.".contains)) ?? 0
                protein = val
            } else if entry.Name == "Total fat" {
                let val = Int(entry.LabelValue.filter("01234567890.".contains)) ?? 0
                fat = val
            }
        }
        
        myOrder.calories += calories * quantity
        myOrder.fat += fat * quantity
        myOrder.carbs += carbs * quantity
        myOrder.protein += protein * quantity
    }
}
