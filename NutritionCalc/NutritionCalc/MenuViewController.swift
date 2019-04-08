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
    var diningCourt = DiningCourt()
    var userMeal:UserMeal = UserMeal()

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
//            print(diningCourt)
            self.setMealTypeIndex()
            
            self.menuTableView.rowHeight = UITableView.automaticDimension
            self.menuTableView.estimatedRowHeight = 100
            self.menuTableView.reloadData()
        })
        
        self.userMeal.date = Date()
    }
    
    func setMealTypeIndex() {
        var index = 0
        for entry in diningCourt.Meals {
            //print(entry.Name + "\n")
            if entry.Name == mealType {
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
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            cell.itemLabel.text = diningCourt.Meals[mealTypeIndex].Stations[indexPath.section].Items[indexPath.row-1].Name
            cell.backgroundColor = nil
            cell.isUserInteractionEnabled = true
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toItemDetail", sender: menuTableView.cellForRow(at: indexPath))
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemDetail" {
            let sendingCell = sender as! MenuCell
            let dest = segue.destination as! ItemNutritionViewController
            
            if let indexPath = menuTableView.indexPath(for: sendingCell) {
                dest.ID = diningCourt.Meals[mealTypeIndex].Stations[indexPath.section].Items[indexPath.row-1].ID
                dest.userMeal = self.userMeal
            }
        } else if segue.identifier == "viewCurrentOrder" {
            if let dest = segue.destination as? CurrentOrderViewController {
                dest.myOrder = userMeal
            }
        }
        else {
            let dest = segue.destination as! HomeScreenViewController
            dest.mealList.append(userMeal)
        }
    }
 
    @IBAction func unwindToItemList(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        print("unwound!")
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        print("submit button")
        // go back to main vc and add the meal to its array
        self.performSegue(withIdentifier: "submitSegue", sender: nil)
        
    }
    
    @IBAction func cancelOrder(_ sender: Any) {
        print("dismissing")
        self.navigationController!.popViewController(animated:  true)
    }
    
    
}
