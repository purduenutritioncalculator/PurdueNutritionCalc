//
//  ItemNutritionViewController.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 3/25/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class ItemNutritionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var types = ["Calories", "Total Fat", "Carbohydrates", "Sugar", "Protein"]
    
    var item: ItemDetail = ItemDetail()
    var ID: String = ""
    var userMeal:UserMeal = UserMeal()

    @IBOutlet weak var itemNutritionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNutritionTableView.delegate = self
        itemNutritionTableView.dataSource = self

        // Do any additional setup after loading the view.
        APICaller.getInfoForFoodItem(id: self.ID) { (itemDetail) in
            self.item = itemDetail
            self.itemNutritionTableView.reloadData()
            self.title = self.item.Name
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (item.Nutrition.count > 0) {
            return item.Nutrition.count
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemNutritionCell") as! ItemNutritionCell
        
        if (item.Nutrition.count > 0) {
            cell.quantityLabel.isHidden = false
            cell.typeLabel.text = item.Nutrition[indexPath.row].Name
            cell.quantityLabel.text = item.Nutrition[indexPath.row].LabelValue
            return cell
        }
        else {
            cell.typeLabel.text = "No Info Available"
            cell.quantityLabel.isHidden = true
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MenuViewController {
            addItemtoMeal(self)
            dest.userMeal = self.userMeal
        }
    }
 

    func addItemtoMeal(_ sender: Any) {
        self.userMeal.foods.append(item)
        
//        let calString = item.Nutrition[1].LabelValue
//        let calories = Int(calString.filter("01234567890.".contains)) ?? 0
//
//        let fatString = item.Nutrition[3].LabelValue
//        let fat = Int(fatString.filter("01234567890.".contains)) ?? 0
//
//        let carbString = item.Nutrition[7].LabelValue
//        let carbs = Int(carbString.filter("01234567890.".contains)) ?? 0
//
//        let proteinString = item.Nutrition[10].LabelValue
//        let protein = Int(proteinString.filter("01234567890.".contains)) ?? 0
        
        self.userMeal.calories += findNutritionVal(type: "Calories")
        self.userMeal.carbs += findNutritionVal(type: "Total Carbohydrates")
        self.userMeal.fat += findNutritionVal(type: "Total fat")
        self.userMeal.protein += findNutritionVal(type: "Protein")
        
        print(self.userMeal)
        
    }
    
    func findNutritionVal(type: String) -> Int {
        
        for entry in item.Nutrition {
            if entry.Name == type {
                let string = entry.LabelValue
                return Int(string.filter("01234567890.".contains)) ?? 0
            }
        }
        
        return 0
    }
    
    
}
