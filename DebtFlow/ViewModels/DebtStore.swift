import Foundation
import SwiftUI

class DebtStore: ObservableObject {
    @Published var debts: [Debt] = [] {
        didSet {
            saveDebts()
        }
    }
    
    private let debtsKey = "saved_debts"
    
    init() {
        loadDebts()
    }
    
    // Computed properties
    var totalOwed: Double {
        debtsOwedToMe.filter { !$0.isCompleted }.reduce(0) { $0 + $1.amount }
    }
    
    var totalIOwe: Double {
        debtsIOwe.filter { !$0.isCompleted }.reduce(0) { $0 + $1.amount }
    }
    
    var totalBalance: Double {
        totalOwed - totalIOwe
    }
    
    var debtsOwedToMe: [Debt] {
        debts.filter { $0.type == .owedToMe }
    }
    
    var debtsIOwe: [Debt] {
        debts.filter { $0.type == .iOwe }
    }
    
    var activeDebts: [Debt] {
        debts.filter { !$0.isCompleted }
    }
    
    var completedDebts: [Debt] {
        debts.filter { $0.isCompleted }
    }
    
    var debtDistribution: [(person: String, amount: Double, color: Color)] {
        let groupedDebts = Dictionary(grouping: activeDebts) { $0.person }
        return groupedDebts.map { person, debts in
            let totalAmount = debts.reduce(0) { total, debt in
                debt.type == .owedToMe ? total + debt.amount : total - debt.amount
            }
            let color: Color = totalAmount >= 0 ? .green : .red
            return (person: person, amount: abs(totalAmount), color: color)
        }.sorted { $0.amount > $1.amount }
    }
    
    // CRUD operations
    func addDebt(_ debt: Debt) {
        debts.append(debt)
    }
    
    func updateDebt(_ debt: Debt) {
        if let index = debts.firstIndex(where: { $0.id == debt.id }) {
            debts[index] = debt
        }
    }
    
    func deleteDebt(_ debt: Debt) {
        debts.removeAll { $0.id == debt.id }
    }
    
    func toggleDebtCompletion(_ debt: Debt) {
        if let index = debts.firstIndex(where: { $0.id == debt.id }) {
            debts[index].isCompleted.toggle()
        }
    }
    
    // Persistence
    private func saveDebts() {
        if let encoded = try? JSONEncoder().encode(debts) {
            UserDefaults.standard.set(encoded, forKey: debtsKey)
        }
    }
    
    private func loadDebts() {
        if let data = UserDefaults.standard.data(forKey: debtsKey),
           let decoded = try? JSONDecoder().decode([Debt].self, from: data) {
            debts = decoded
        }
    }
}