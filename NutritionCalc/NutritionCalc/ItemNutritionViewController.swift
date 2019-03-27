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
    
    var itemsStats = [String:Int]()

    @IBOutlet weak var itemNutritionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNutritionTableView.delegate = self
        itemNutritionTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemNutritionCell") as! ItemNutritionCell
        cell.typeLabel.text = types[indexPath.row]
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
