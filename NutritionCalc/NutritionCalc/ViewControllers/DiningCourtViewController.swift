//
//  DiningCourtViewController.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 3/20/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit

class DiningCourtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var diningCourts = ["1Bowl", "Earhart", "Ford", "Hillenbrand", "Pete's Za", "Wiley", "Windsor"]
    
    @IBOutlet weak var diningCourtTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diningCourtTableView.delegate = self
        diningCourtTableView.dataSource = self
        
        let backgroundImage = UIImageView(image: UIImage(named: "purduelogo"))
        backgroundImage.contentMode = .scaleAspectFit
        diningCourtTableView.backgroundView = backgroundImage
        diningCourtTableView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diningCourtCell") as! DiningCourtCell
        cell.diningCourtLabel.text = diningCourts[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = diningCourtTableView.indexPath(for: cell)!
        let diningCourt = diningCourts[indexPath.row]
        
        let mealSelectViewController = segue.destination as! MealTypeController
        mealSelectViewController.diningCourt = diningCourt
    }
}
