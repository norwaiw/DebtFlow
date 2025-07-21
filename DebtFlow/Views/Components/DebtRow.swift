import SwiftUI

struct DebtRow: View {
    let debt: Debt
    @ObservedObject var store: DebtStore
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = NSLocalizedString("common.currency", comment: "")
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(debt.person)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .strikethrough(debt.isCompleted)
                
                if !debt.description.isEmpty {
                    Text(debt.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Text(dateFormatter.string(from: debt.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                HStack(spacing: 2) {
                    Text(debt.type.sign)
                        .font(.system(size: 14, weight: .medium))
                    Text(currencyFormatter.string(from: NSNumber(value: debt.amount)) ?? "")
                        .font(.system(size: 16, weight: .bold))
                }
                .foregroundColor(debt.type == .owedToMe ? .green : .red)
                .opacity(debt.isCompleted ? 0.5 : 1.0)
                
                if debt.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}