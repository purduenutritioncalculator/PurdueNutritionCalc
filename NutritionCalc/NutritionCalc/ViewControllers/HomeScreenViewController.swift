//
//  HomeScreenViewController.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/1/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import UIKit
import CoreData
import M13ProgressSuite

class HomeScreenViewController: UIViewController {
    
    var mealList = [UserMeal]()
    var savedMeals = [MealModel]()

    @IBOutlet weak var calorieProgressContainer: UIView!
    @IBOutlet weak var proteinProgressContainer: UIView!
    @IBOutlet weak var fatProgressContainer: UIView!
    @IBOutlet weak var carbProgressContainer: UIView!
    
    var calorieProgress:M13ProgressViewRing? = M13ProgressViewRing()
    var fatProgress:M13ProgressViewRing? = M13ProgressViewRing()
    var carbProgress:M13ProgressViewRing? = M13ProgressViewRing()
    var proteinProgress:M13ProgressViewRing? = M13ProgressViewRing()
    
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(mealList)
        
        let fetchRequest: NSFetchRequest<MealModel> = MealModel.fetchRequest()
        
        do {
            let meals = try PersistenceService.context.fetch(fetchRequest)
            self.savedMeals = meals
        } catch {
            print("error")
        }
        // Do any additional setup after loading the view.
        print("total meals: \(savedMeals.count)")
        
        let todaysMeals = getTodaysMeal()
        var todaysCals = 0.0
        var todaysFats = 0.0
        var todaysProt = 0.0
        var todaysCarbs = 0.0
        
        for entry in todaysMeals {
            todaysCals += Double(entry.calories)
            todaysFats += Double(entry.fats)
            todaysProt += Double(entry.protein)
            todaysCarbs += Double(entry.carbs)
        }
        
        calorieProgressContainer.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        fatProgressContainer.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        proteinProgressContainer.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        carbProgressContainer.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        self.calorieProgress = M13ProgressViewRing(frame: CGRect(x: 0, y: 0, width: calorieProgressContainer.frame.width, height: calorieProgressContainer.frame.height))
        calorieProgress!.setProgress(CGFloat(todaysCals / 2000.0), animated: true)
        if (todaysCals / 2000.0 > 1.0) {
            calorieProgress!.primaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            calorieProgress!.secondaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            calorieProgress!.primaryColor = M13ProgressViewRing().primaryColor
            calorieProgress!.secondaryColor = M13ProgressViewRing().secondaryColor
        }
        calorieProgressContainer.addSubview(calorieProgress!)
        calorieLabel.text = "Calories: \(todaysCals)"
        
        self.fatProgress = M13ProgressViewRing(frame: CGRect(x: 0, y: 0, width: calorieProgressContainer.frame.width, height: calorieProgressContainer.frame.height))
        fatProgress!.setProgress(CGFloat(todaysFats / 60.0), animated: true)
        if (todaysFats / 60.0 > 1.0) {
            fatProgress!.primaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            fatProgress!.secondaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            fatProgress!.primaryColor = M13ProgressViewRing().primaryColor
            fatProgress!.secondaryColor = M13ProgressViewRing().secondaryColor
        }
        fatProgressContainer.addSubview(fatProgress!)
        fatLabel.text = "Fats: \(todaysFats)g"
        
        self.carbProgress = M13ProgressViewRing(frame: CGRect(x: 0, y: 0, width: calorieProgressContainer.frame.width, height: calorieProgressContainer.frame.height))
        carbProgress!.setProgress(CGFloat(todaysCarbs / 275.0), animated: true)
        if (todaysCarbs / 275.0 > 1.0) {
            carbProgress!.primaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            carbProgress!.secondaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            carbProgress!.primaryColor = M13ProgressViewRing().primaryColor
            carbProgress!.secondaryColor = M13ProgressViewRing().secondaryColor
        }
        carbProgressContainer.addSubview(carbProgress!)
        carbLabel.text = "Carbs: \(todaysCarbs)g"
        
        self.proteinProgress = M13ProgressViewRing(frame: CGRect(x: 0, y: 0, width: calorieProgressContainer.frame.width, height: calorieProgressContainer.frame.height))
        proteinProgress!.setProgress(CGFloat(todaysProt / 52.0), animated: true)
        if (todaysProt / 52.0 > 1.0) {
            proteinProgress!.primaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            proteinProgress!.secondaryColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        } else {
            proteinProgress!.primaryColor = M13ProgressViewRing().primaryColor
            proteinProgress!.secondaryColor = M13ProgressViewRing().secondaryColor
        }
        proteinProgressContainer.addSubview(proteinProgress!)
        proteinLabel.text = "Protein: \(todaysProt)g"
        
        
    }
    
    func getTodaysMeal() -> [MealModel] {
        var todayMeals = [MealModel]()
        
        for meal in savedMeals {
            
            let today = Calendar.current.isDateInToday(meal.date! as Date)
            if today {
                todayMeals.append(meal)
            }
        }
        
        return todayMeals
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

    @IBAction func startOrder(_ sender: Any) {
        performSegue(withIdentifier: "beginOrder", sender: self)
    }
    
    @IBAction func unwindToHome(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        print("unwound!")
    }
}
