//
//  AddBudgetCategoryView.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI

//MARK: - CLASS
struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var total: Double = 100
    @State private var messages: [String] = []
    
    var isFormValid: Bool {
        self.checkFormValidation()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Titulo", text: $title)
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text(0 as NSNumber, formatter: NumberFormatter.currency)
                } maximumValueLabel: {
                    Text(500 as NSNumber, formatter: NumberFormatter.currency)
                }
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        isFormValid ? save() : nil
                    }
                }
            }
        }
    }
}

//MARK: - FUNCTIONS
extension AddBudgetCategoryView {
    private func save() {
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - VALIDATIONS
extension AddBudgetCategoryView {
    private func checkFormValidation() -> Bool {
        messages.removeAll()
        
        if title.isEmpty {
            messages.append("Preencha o título")
        }
        if total <= 0 {
            messages.append("Total deve ser maior que 1")
        }
        
        return messages.count == 0
    }
}

//MARK: - PREVIEW
#Preview {
    AddBudgetCategoryView()
}
