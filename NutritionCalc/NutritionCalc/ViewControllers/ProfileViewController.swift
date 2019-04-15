//
//  ProfileViewController.swift
//  NutritionCalc
//
//  Created by Zach on 4/8/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var todayCals: UILabel!
    
    var myMealHistory = [MealModel]()
    var todayMeals = [MealModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        todayCals.text = "25"

        let fetchRequest: NSFetchRequest<MealModel> = MealModel.fetchRequest()
        
        do {
            let meals = try PersistenceService.context.fetch(fetchRequest)
            self.myMealHistory = meals
        } catch {
            print("error")
        }
        print("profile array length: \(myMealHistory.count)")
        // Do any additional setup after loading the view.
        getTodaysMeal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("profile array length: \(myMealHistory.count)")
    }
    
    func getTodaysMeal() {
        let today = NSDate()
        for meal in myMealHistory {
            let todayy = Calendar.current.isDateInToday(meal.date as! Date)
            if todayy {
                todayMeals.append(meal)
            }
        }
        print("first meal cals = \(self.myMealHistory[0].calories)")
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
