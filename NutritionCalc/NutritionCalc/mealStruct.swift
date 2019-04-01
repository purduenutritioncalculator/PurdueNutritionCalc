//
//  mealStruct.swift
//  NutritionCalc
//
//  Created by Grant Yolasan on 4/1/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import Foundation

struct UserMeal {
    var calories:Int
    var protein:Int
    var fat:Int
    var carbs:Int
    var foods:[String]
    
    init() {
        calories = 0
        protein = 0
        fat = 0
        carbs = 0
        foods = []
    }
}
