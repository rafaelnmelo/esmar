//
//  BudgetDetailView.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import SwiftUI

//MARK: - CLASS
struct BudgetDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    let budgetCategory: BudgetCategory
    
    var isFormValid: Bool {
        self.checkFormValidation()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack {
                        Text("Orçamento:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }
            }
            
            Form {
                Section {
                    TextField("Nome", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Adicionar transação")
                }
                HStack {
                    Spacer()
                    Button("Salvar") {
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
            .padding([.bottom], 20)
            VStack {
                BudgetSummaryView(budgetCategory: budgetCategory)
                TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            }
            Spacer()
        }.padding()
    }
}

//MARK: - FUNCTIONS
extension BudgetDetailView {
    private func saveTransaction(){
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total) ?? 0
            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
            clearTextfields()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteTransaction(_ transaction: Transaction){
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func clearTextfields() {
        title = ""
        total = ""
    }
}

//MARK: - VALIDATIONS
extension BudgetDetailView {
    private func checkFormValidation() -> Bool {
        guard let totalAsDouble = Double(total) else {return false}
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
}

//MARK: - PREVIEW
#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
