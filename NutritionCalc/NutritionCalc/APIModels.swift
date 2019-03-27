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
    
    let Name:String  // Breakfast, Lunch, or Dinner
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
    let Nutrition: [NutritionItem]
    
    init () {
        self.ID = ""
        self.Name = ""
        self.Nutrition = []
    }
    
    
}

struct NutritionItem: Decodable {
    let Name:String
    let LabelValue:String
    let Ordinal: Int
    
    init(name: String, labelValue: String, ordinal: Int) {
        self.Name = name
        self.LabelValue = labelValue
        self.Ordinal = ordinal
    }
    
    enum CodingKeys: String, CodingKey {
        case Name = "Name"
        case LabelValue = "LabelValue"
        case Ordinal = "Ordinal"
    }
}

extension NutritionItem {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try? container.decode(String.self, forKey: .Name)
        let labelValue = try? container.decode(String.self, forKey: .Name)
        let ordinal = try? container.decode(Int.self, forKey: .Name)
        
        
        self.init(name: name ?? "", labelValue: labelValue ?? "", ordinal: ordinal ?? 0)
    }
    
}
