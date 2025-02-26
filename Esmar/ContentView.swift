//
//  ContentView.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI
import CoreData

//MARK: - CLASS
struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented = false
    
    var total: Double {
        calculateTotal()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                BudgetListView(budgetCategoryResults: budgetCategoryResults)
            }
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+ categorias") {
                        isPresented = true
                    }
                }
            }.padding()
        }
    }
}

//MARK: - FUNCTIONS
extension ContentView {
    private func calculateTotal() -> Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            result + budgetCategory.total
        }
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
