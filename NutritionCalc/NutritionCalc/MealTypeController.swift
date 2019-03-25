//
//  MealTypeController.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 3/22/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class MealTypeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var meals = [[String: Any]]()
    @IBOutlet weak var mealSelectTableView: UITableView!
    
    var diningCourt = ""
    // meals
    // iterate through meals to find the selected meal
    // once found index the stations element
    // Stations[1] = the menu
    var selectedMealMenu = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mealSelectTableView.delegate = self
        mealSelectTableView.dataSource = self
        
        mealSelectTableView.rowHeight = 100
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date)
        
        print("Dining court: \(diningCourt) Date: \(result)")
        
        let url = URL(string: "https://api.hfs.purdue.edu/menus/v2/locations/\(diningCourt)/\(result)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                self.meals = dataDictionary["Meals"] as! [[String:Any]]
                
                //                print(self.meals)
                print(self.meals[0]["ID"])
                self.mealSelectTableView.reloadData()

            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealSelectCell") as! MealSelectCell
        cell.mealTypeLabel.text = meals[indexPath.row]["Name"] as! String
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = mealSelectTableView.indexPath(for: cell)!
        let mealType = meals[indexPath.row]["Name"] as! String
        let menuViewController = segue.destination as! MenuViewController
        
        menuViewController.diningCourt = diningCourt
        menuViewController.mealType = mealType
        menuViewController.meals = meals
    }
}
