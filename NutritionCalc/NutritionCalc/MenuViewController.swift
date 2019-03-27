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
    var mealTypeIndex = -1

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
            print(diningCourt)
            self.setMealTypeIndex()
            self.menuTableView.reloadData()
        })
    }
    
    func setMealTypeIndex() {
        var index = 0
        for entry in diningCourt.Meals {
            if entry.Type == mealType {
                mealTypeIndex = index
                break
            }
            index += 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mealTypeIndex != -1 {
            return self.diningCourt.Meals[mealTypeIndex].Stations[section].Items.count + 1
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if mealTypeIndex != -1 {
            return self.diningCourt.Meals[mealTypeIndex].Stations.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuCell
        
        if (mealTypeIndex == -1) {
            cell.itemLabel.text = "Unable to get menu data"
            return cell
        }
        
        if (indexPath.row == 0) {
            cell.itemLabel.text = diningCourt.Meals[mealTypeIndex].Stations[indexPath.section].Name
            cell.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            return cell
        } else {
            cell.itemLabel.text = diningCourt.Meals[mealTypeIndex].Stations[indexPath.section].Items[indexPath.row-1].Name
            cell.backgroundColor = nil
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
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
