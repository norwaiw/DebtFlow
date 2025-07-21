import SwiftUI

struct DebtsScreen: View {
    @ObservedObject var store: DebtStore
    @State private var showingAddDebt = false
    @State private var editingDebt: Debt?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(
                    totalBalance: store.totalBalance,
                    totalOwed: store.totalOwed,
                    totalIOwe: store.totalIOwe
                )
                .padding(.vertical)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // I'm Owed Section
                        if !store.debtsOwedToMe.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("debts.im_owed")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                    .padding(.horizontal)
                                
                                ForEach(store.debtsOwedToMe) { debt in
                                    DebtRow(debt: debt, store: store)
                                        .padding(.horizontal)
                                        .contextMenu {
                                            Button {
                                                editingDebt = debt
                                            } label: {
                                                Label("debts.edit", systemImage: "pencil")
                                            }
                                            
                                            Button {
                                                store.toggleDebtCompletion(debt)
                                            } label: {
                                                Label(debt.isCompleted ? "debts.mark_incomplete" : "debts.mark_complete", 
                                                      systemImage: debt.isCompleted ? "xmark.circle" : "checkmark.circle")
                                            }
                                            
                                            Button(role: .destructive) {
                                                store.deleteDebt(debt)
                                            } label: {
                                                Label("debts.delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                        
                        // I Owe Section
                        if !store.debtsIOwe.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("debts.i_owe")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                    .padding(.horizontal)
                                
                                ForEach(store.debtsIOwe) { debt in
                                    DebtRow(debt: debt, store: store)
                                        .padding(.horizontal)
                                        .contextMenu {
                                            Button {
                                                editingDebt = debt
                                            } label: {
                                                Label("debts.edit", systemImage: "pencil")
                                            }
                                            
                                            Button {
                                                store.toggleDebtCompletion(debt)
                                            } label: {
                                                Label(debt.isCompleted ? "debts.mark_incomplete" : "debts.mark_complete", 
                                                      systemImage: debt.isCompleted ? "xmark.circle" : "checkmark.circle")
                                            }
                                            
                                            Button(role: .destructive) {
                                                store.deleteDebt(debt)
                                            } label: {
                                                Label("debts.delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                        
                        // Empty State
                        if store.debts.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "tray")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray)
                                Text("common.no_debts")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("debts.title")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddDebt = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddDebt) {
            AddEditDebtView(store: store)
        }
        .sheet(item: $editingDebt) { debt in
            AddEditDebtView(store: store, debt: debt)
        }
        .preferredColorScheme(.dark)
    }
}