//
//  BudgetCategory+CoreDataClass.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
