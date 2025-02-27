//
//  SheetAction.swift
//  Esmar
//
//  Created by Rafael Nunes on 27/02/25.
//

import Foundation

enum SheetAction: Identifiable {
   case add
   case edit(BudgetCategory)
 
var id: Int {
  switch self {
     case .add:
  return 1
     case .edit(_):
  return 2
     }
  }
}
