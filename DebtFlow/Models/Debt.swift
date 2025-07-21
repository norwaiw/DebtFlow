import Foundation

struct Debt: Identifiable, Codable {
    let id: UUID
    var person: String
    var description: String
    var date: Date
    var amount: Double
    var type: DebtType
    var isCompleted: Bool
    
    init(id: UUID = UUID(), person: String, description: String, date: Date = Date(), amount: Double, type: DebtType, isCompleted: Bool = false) {
        self.id = id
        self.person = person
        self.description = description
        self.date = date
        self.amount = amount
        self.type = type
        self.isCompleted = isCompleted
    }
}

enum DebtType: String, Codable, CaseIterable {
    case owedToMe = "owed_to_me"
    case iOwe = "i_owe"
    
    var displayColor: String {
        switch self {
        case .owedToMe:
            return "green"
        case .iOwe:
            return "red"
        }
    }
    
    var sign: String {
        switch self {
        case .owedToMe:
            return "+"
        case .iOwe:
            return "-"
        }
    }
}