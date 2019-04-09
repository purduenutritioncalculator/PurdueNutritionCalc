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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentOrderTableView.dataSource = self
        currentOrderTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrder.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentOrderItem") as! MenuCell
        
        cell.itemLabel.text = myOrder.foods[indexPath.row].Name
        
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
