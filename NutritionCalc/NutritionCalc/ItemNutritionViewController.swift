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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
