//
//  userStruct.swift
//  NutritionCalc
//
//  Created by Anderson David on 4/17/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var name: String
    var sex: Int  // 0 is male, 1 is female
    var age: Int
    var feet: Int
    var inches: Double
    var weight: Double
    var calories: Int
    var protein: Int
    var fat: Int
    var carbs: Int
    
    init() {
        name = ""
        age = 0
        feet = 0
        inches = 0
        weight = 0
        calories = 0
        protein = 0
        fat = 0
        carbs = 0
        sex = 0
    }
    
    init(name: String, sex: Int, age: Int, feet: Int, inches: Double, weight: Double, calories: Int, protein: Int, fat: Int, carbs: Int) {
        self.name = name
        self.sex = sex
        self.age = age
        self.feet = feet
        self.inches = inches
        self.weight = weight
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
    }
}
