import SwiftUI

struct AddEditDebtView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: DebtStore
    
    let debt: Debt?
    
    @State private var person = ""
    @State private var description = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var debtType: DebtType = .owedToMe
    
    init(store: DebtStore, debt: Debt? = nil) {
        self.store = store
        self.debt = debt
        
        if let debt = debt {
            _person = State(initialValue: debt.person)
            _description = State(initialValue: debt.description)
            _amount = State(initialValue: String(debt.amount))
            _date = State(initialValue: debt.date)
            _debtType = State(initialValue: debt.type)
        }
    }
    
    private var isEditMode: Bool {
        debt != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("form.person_name", text: $person)
                    TextField("form.description", text: $description)
                    
                    HStack {
                        Text("form.amount")
                        Spacer()
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    DatePicker("form.date", selection: $date, displayedComponents: .date)
                    
                    Picker("form.type", selection: $debtType) {
                        Text("form.owed_to_me").tag(DebtType.owedToMe)
                        Text("form.i_owe").tag(DebtType.iOwe)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle(isEditMode ? "debts.edit" : "debts.add_new")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("form.cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditMode ? "form.save" : "form.add") {
                        saveDebt()
                    }
                    .disabled(person.isEmpty || amount.isEmpty)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func saveDebt() {
        guard let amountValue = Double(amount) else { return }
        
        if isEditMode, let existingDebt = debt {
            let updatedDebt = Debt(
                id: existingDebt.id,
                person: person,
                description: description,
                date: date,
                amount: amountValue,
                type: debtType,
                isCompleted: existingDebt.isCompleted
            )
            store.updateDebt(updatedDebt)
        } else {
            let newDebt = Debt(
                person: person,
                description: description,
                date: date,
                amount: amountValue,
                type: debtType
            )
            store.addDebt(newDebt)
        }
        
        dismiss()
    }
}