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
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userSex: UILabel!
    
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userHeight: UILabel!
    @IBOutlet weak var userWeight: UILabel!
    @IBOutlet weak var todayCals: UILabel!
    @IBOutlet weak var todaysProtein: UILabel!
    
    @IBOutlet weak var todaysFat: UILabel!
    @IBOutlet weak var todaysCarbs: UILabel!
    
    @IBOutlet weak var dailyCaloriesNeeded: UILabel!
    
    @IBOutlet weak var dailyProteinNeeded: UILabel!
    
    @IBOutlet weak var dailyCarbsNeeded: UILabel!
    
    @IBOutlet weak var dailyFatsNeeded: UILabel!
    var myMealHistory = [MealModel]()
    var todayMeals = [MealModel]()

    @IBOutlet weak var calsProgress: UIProgressView!
    
    @IBOutlet weak var carbProgress: UIProgressView!
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var fatProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayCals.text = "25"
        fetchMeals()
        
        print("profile array length: \(myMealHistory.count)")
        getTodaysMeal()
        setLabels()
    }
    
    func fetchMeals() {
        let fetchRequest: NSFetchRequest<MealModel> = MealModel.fetchRequest()
        
        do {
            let meals = try PersistenceService.context.fetch(fetchRequest)
            self.myMealHistory = meals
        } catch {
            print("error")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("calling view did appear...\n")
        fetchMeals()
        
        let decoder = PropertyListDecoder()
        
        if let userInfo = try? decoder.decode(User.self, from: (UserDefaults.standard.value(forKey: "UserInfo") as? Data)!) {
            userName.text = userInfo.name
            userAge.text = "\(userInfo.age)"
            userHeight.text = "\(userInfo.feet)' \(userInfo.inches)\""
            userWeight.text = "\(userInfo.weight)lbs"
            dailyCaloriesNeeded.text = "\(userInfo.calories)"
            dailyFatsNeeded.text = "\(userInfo.fat)g"
            dailyCarbsNeeded.text = "\(userInfo.carbs)g"
            dailyProteinNeeded.text = "\(userInfo.protein)g"
            if userInfo.sex == 0 {
                userSex.text = "Male"
            } else {
                userSex.text = "Female"
            }
        }
        getTodaysMeal()
        setLabels()
    }
    
    func getTodaysMeal() {
        todayMeals = []
        for meal in myMealHistory {
            
            let today = Calendar.current.isDateInToday(meal.date! as Date)
            if today {
                todayMeals.append(meal)
            }
        }
//        print("first meal cals = \(self.myMealHistory[0].calories)")
//        print("total meals today \(self.todayMeals.count)")
    }
    
    func setLabels() {
        var cals = 0
        var protein = 0
        var carbs = 0
        var fat = 0
        for meal in todayMeals {
            cals += Int(meal.calories)
            fat += Int(meal.fats)
            carbs += Int(meal.carbs)
            protein += Int(meal.protein)
        }
        todaysProtein.text = String(protein)
        todaysCarbs.text = String(carbs)
        todaysFat.text = String(fat)
        todayCals.text = String(cals)
        
        let decoder = PropertyListDecoder()

        if let userInfo = try? decoder.decode(User.self, from: (UserDefaults.standard.value(forKey: "UserInfo") as? Data)!) {
            calsProgress.progress = Float(cals) / Float(userInfo.calories)
            carbProgress.progress = Float(carbs) / Float(userInfo.carbs)
            fatProgress.progress = Float(fat) / Float(userInfo.fat)
            proteinProgress.progress = Float(protein) / Float(userInfo.protein)
        }
    }
    
    func fillProfile(name: String, age: String, sex: String, height: String, weight: String, calories: String, protein: String, carbs: String, fats: String) {
        userName.text = name
        userAge.text = age
        userSex.text = sex
        userHeight.text = height
        userWeight.text = weight
        dailyCaloriesNeeded.text = calories
        dailyFatsNeeded.text = fats
        dailyCarbsNeeded.text = carbs
        dailyProteinNeeded.text = protein
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func unwindToProfile(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        return
    }

}
