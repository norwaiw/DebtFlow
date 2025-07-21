import SwiftUI
import Charts

struct StatisticsScreen: View {
    @ObservedObject var store: DebtStore
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = NSLocalizedString("common.currency", comment: "")
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Pie Chart
                    if !store.debtDistribution.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("statistics.debt_distribution")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart(store.debtDistribution, id: \.person) { item in
                                SectorMark(
                                    angle: .value("Amount", item.amount),
                                    innerRadius: .ratio(0.5),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(item.color)
                                .cornerRadius(5)
                            }
                            .frame(height: 300)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            
                            // Legend
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(store.debtDistribution, id: \.person) { item in
                                    HStack {
                                        Circle()
                                            .fill(item.color)
                                            .frame(width: 12, height: 12)
                                        Text(item.person)
                                            .font(.subheadline)
                                        Spacer()
                                        Text(currencyFormatter.string(from: NSNumber(value: item.amount)) ?? "")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    } else {
                        // Empty state for chart
                        VStack(spacing: 16) {
                            Image(systemName: "chart.pie")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("statistics.no_data")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Summary Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("statistics.summary")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            // Active vs Completed
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("statistics.active_debts")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(store.activeDebts.count)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("statistics.completed_debts")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(store.completedDebts.count)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                            }
                            
                            Divider()
                            
                            // Financial Summary
                            VStack(spacing: 12) {
                                HStack {
                                    Text("statistics.total_owed_to_me")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(currencyFormatter.string(from: NSNumber(value: store.totalOwed)) ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.green)
                                }
                                
                                HStack {
                                    Text("statistics.total_i_owe")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(currencyFormatter.string(from: NSNumber(value: store.totalIOwe)) ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.red)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("statistics.net_balance")
                                        .font(.headline)
                                    Spacer()
                                    Text(currencyFormatter.string(from: NSNumber(value: store.totalBalance)) ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(store.totalBalance >= 0 ? .green : .red)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("statistics.title")
        }
        .preferredColorScheme(.dark)
    }
}