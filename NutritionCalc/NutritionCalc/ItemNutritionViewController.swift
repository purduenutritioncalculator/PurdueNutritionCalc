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
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.Nutrition.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemNutritionCell") as! ItemNutritionCell
        cell.typeLabel.text = item.Nutrition[indexPath.row].Name
        cell.quantityLabel.text = item.Nutrition[indexPath.row].LabelValue
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MenuViewController {
            dest.userMeal = self.userMeal
        }
    }
 

    @IBAction func addItemtoMeal(_ sender: Any) {
        self.userMeal.foods.append(item.Name)
        
        let calString = item.Nutrition[1].LabelValue
        let calories = Int(calString.filter("01234567890.".contains)) ?? 0
        
        let fatString = item.Nutrition[3].LabelValue
        let fat = Int(fatString.filter("01234567890.".contains)) ?? 0
        
        let carbString = item.Nutrition[7].LabelValue
        let carbs = Int(carbString.filter("01234567890.".contains)) ?? 0
        
        let proteinString = item.Nutrition[10].LabelValue
        let protein = Int(proteinString.filter("01234567890.".contains)) ?? 0
        
        self.userMeal.calories += calories
        self.userMeal.carbs += carbs
        self.userMeal.fat += fat
        self.userMeal.protein += protein
        
        print(self.userMeal)
        
    }
    
    
}
