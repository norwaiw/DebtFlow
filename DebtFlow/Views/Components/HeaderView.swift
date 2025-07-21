import SwiftUI

struct HeaderView: View {
    let totalBalance: Double
    let totalOwed: Double
    let totalIOwe: Double
    
    var body: some View {
        HStack(spacing: 0) {
            // All balance
            VStack(spacing: 4) {
                Text("debts.all")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(formatCurrency(totalBalance))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(totalBalance >= 0 ? .green : .red)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 40)
                .overlay(Color.gray.opacity(0.3))
            
            // I'm Owed
            VStack(spacing: 4) {
                Text("debts.im_owed")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(formatCurrency(totalOwed))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 40)
                .overlay(Color.gray.opacity(0.3))
            
            // I Owe
            VStack(spacing: 4) {
                Text("debts.i_owe")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(formatCurrency(totalIOwe))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = NSLocalizedString("common.currency", comment: "")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "$0"
    }
}