//
//  APIModels.swift
//  NutritionCalc
//
//  Created by Anderson David on 3/25/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import Foundation

struct DiningCourt: Decodable {

    let Location:String
    let Date:String
    let Meals:[Meal]
    
    init(Location:String, Date:String, Meals: [Meal]) {
        self.Location = Location
        self.Date = Date
        self.Meals = Meals
    }
    
    init() {
        self.Location = ""
        self.Date = ""
        self.Meals = []
    }
    
}

struct Meal: Decodable {
    
    let `Type`:String  // Breakfast, Lunch, or Dinner
    let Stations:[Station]
    
}

struct Station: Decodable {
    
    let Name:String
    let Items:[Item]
    
}

struct Item: Decodable {
    
    let ID:String
    let Name:String
    
}

struct ItemDetail: Decodable {
    
    let ID:String
    let Name: String
    let Nutrition: [String:String]
    let Calories: Int
    let Fat: Int
    let Carbs: Int
    let Sugar: Int
    let Protein: Int
    
}
