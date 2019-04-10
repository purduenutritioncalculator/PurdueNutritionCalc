//
//  MealModel+CoreDataProperties.swift
//  
//
//  Created by Grant Yolasan on 4/10/19.
//
//

import Foundation
import CoreData


extension MealModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealModel> {
        return NSFetchRequest<MealModel>(entityName: "MealModel")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var protein: Int16
    @NSManaged public var carbs: Int16
    @NSManaged public var fats: Int16
    @NSManaged public var date: NSDate?

}
