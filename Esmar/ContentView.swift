//
//  ContentView.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List(budgetCategoryResults) { budgetCategory in
                    Text(budgetCategory.title ?? "")
                }
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

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
