//
//  Transaction+CoreDataClass.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import Foundation
import CoreData

public class Transaction: NSManagedObject {
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
