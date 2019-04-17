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
    
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var itemNutritionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemNutritionTableView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)

        itemNutritionTableView.delegate = self
        itemNutritionTableView.dataSource = self

        // Do any additional setup after loading the view.
        APICaller.getInfoForFoodItem(id: self.ID) { (itemDetail) in
            self.item = itemDetail
            self.itemNutritionTableView.reloadData()
            self.title = self.item.Name
        }
        self.view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (item.Nutrition.count > 0) {
            return item.Nutrition.count
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemNutritionCell") as! ItemNutritionCell
        cell.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)
        cell.quantityLabel.textColor = UIColor.white
        cell.typeLabel.textColor = UIColor.white

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
        
        let quantity = Int(quantityField.text!) ?? 1
        self.userMeal.quantities.append(quantity)
        
        self.userMeal.calories += findNutritionVal(type: "Calories") * quantity
        self.userMeal.carbs += findNutritionVal(type: "Total Carbohydrate") * quantity
        self.userMeal.fat += findNutritionVal(type: "Total fat") * quantity
        self.userMeal.protein += findNutritionVal(type: "Protein") * quantity
        
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
    
    @IBAction func increaseQuantity(_ sender: Any) {
        var curQuantity = Int(quantityField.text!)!
        curQuantity += 1
        quantityField.text = "\(curQuantity)"
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        var curQuantity = Int(quantityField.text!)!
        if (curQuantity > 1) {
            curQuantity -= 1
            quantityField.text = "\(curQuantity)"
        }
    }
    
    
    
}
