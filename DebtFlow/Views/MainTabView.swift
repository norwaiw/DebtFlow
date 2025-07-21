import SwiftUI

struct MainTabView: View {
    @StateObject private var store = DebtStore()
    
    var body: some View {
        TabView {
            DebtsScreen(store: store)
                .tabItem {
                    Label("tab.debts", systemImage: "list.bullet.rectangle")
                }
            
            StatisticsScreen(store: store)
                .tabItem {
                    Label("tab.statistics", systemImage: "chart.pie")
                }
            
            SettingsScreen()
                .tabItem {
                    Label("tab.settings", systemImage: "gear")
                }
        }
        .preferredColorScheme(.dark)
    }
}