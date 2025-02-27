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
    
    var overSpent: Bool {
        remainingBudgetTotal < 0
    }
    
    var transactionsTotal: Double {
        transactionArray.reduce(0) { partialResult, transaction in
            partialResult + transaction.total
        }
    }
    
    var remainingBudgetTotal: Double {
        self.total - transactionsTotal
    }
    
    static var all: NSFetchRequest<BudgetCategory> {
        let request = BudgetCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }
    
    private var transactionArray: [Transaction] {
        guard let transactions = transactions else { return []}
        let allTransactions = (transactions.allObjects as? [Transaction] ?? [])
        return allTransactions.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }
    
    static func byID(_ id: NSManagedObjectID) -> BudgetCategory {
        let viewContext = CoreDataManager.shared.viewContext
        guard let budgetCategory = viewContext.object(with: id) as? BudgetCategory else {
            fatalError("ID not found")
        }
        return budgetCategory
    }
    
    static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
}
