//
//  MenuViewController.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 3/23/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var name = ""
    var mealType = ""

    var meals = [[String: Any]]()
    var selectedMeal = [[String: Any]]()
    // menu is an dictionary which has the item name and id
    var menu = [String:String]()
    var diningCourt = DiningCourt()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date)
        
        print("You chose \(name) for \(mealType) on \(result)")
        
        // make api call here
        APICaller.getInfoForDiningCourt(diningCourt: name, date: result, completion: { diningCourt in
            self.diningCourt = diningCourt
            self.menuTableView.reloadData()
        })
        print(diningCourt)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows: \(self.diningCourt.Meals[section].Stations.count)\n")
        return diningCourt.Meals[section].Stations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("number of sections: \(self.diningCourt.Meals.count)\n")
        return self.diningCourt.Meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuCell
        
        if (indexPath.row == 0) {
            cell.itemLabel.text = diningCourt.Meals[indexPath.section].Type
        } else {
            cell.itemLabel.text = diningCourt.Meals[indexPath.section].Stations[indexPath.row - 1].Name
        }
        
        print("returning cell...\n")
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
