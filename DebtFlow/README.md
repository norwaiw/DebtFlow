# DebtFlow - Debt Tracking App

A beautiful and intuitive debt tracking app built with SwiftUI that helps you manage who owes you money and who you owe money to.

## Features

### 📱 Main Features
- **Debt Management**: Track debts you owe and debts owed to you
- **Dark Mode**: Beautiful dark theme with card-style UI
- **Localization**: Full support for English and Russian languages
- **Statistics**: Visual debt distribution with pie charts
- **Data Persistence**: All debts are saved locally

### 🎨 UI Features
- Custom dark theme with light text
- Card-style list items with shadows
- Three-column header showing total balance
- Red/green amount indicators
- Tab bar navigation
- Swipe actions for delete/edit
- Context menu for additional actions

### 📊 Statistics
- Interactive pie chart showing debt distribution by person
- Active vs completed debt counters
- Total debt summary with net balance
- Color-coded visualization (green for money owed to you, red for money you owe)

## Requirements

- iOS 16.0+ (required for SwiftUI Charts)
- Xcode 14.0+
- Swift 5.7+

## Setup Instructions

1. **Create a new Xcode project**:
   - Open Xcode
   - Create new project → iOS → App
   - Product Name: DebtFlow
   - Interface: SwiftUI
   - Language: Swift
   - Use Core Data: No
   - Include Tests: Optional

2. **Copy the project files**:
   - Replace the default project files with the files from this DebtFlow directory
   - Make sure to maintain the folder structure

3. **Configure the project**:
   - Select the project in Xcode
   - Go to the target settings
   - Set Deployment Target to iOS 16.0
   - Add supported localizations: English and Russian

4. **Build and Run**:
   - Select a simulator or device
   - Press Cmd+R to build and run

## Project Structure

```
DebtFlow/
├── Models/
│   └── Debt.swift              # Debt data model
├── ViewModels/
│   └── DebtStore.swift         # Data management and business logic
├── Views/
│   ├── Components/
│   │   ├── HeaderView.swift    # Three-column header
│   │   ├── DebtRow.swift       # Individual debt row
│   │   └── AddEditDebtView.swift # Add/Edit form
│   ├── Screens/
│   │   ├── DebtsScreen.swift   # Main debts list
│   │   ├── StatisticsScreen.swift # Statistics with charts
│   │   └── SettingsScreen.swift # Settings and language
│   └── MainTabView.swift       # Tab navigation
├── Localization/
│   ├── en.lproj/
│   │   └── Localizable.strings # English translations
│   └── ru.lproj/
│       └── Localizable.strings # Russian translations
├── DebtFlowApp.swift           # App entry point
└── Info.plist                  # App configuration
```

## Usage

### Adding a Debt
1. Tap the + button on the Debts screen
2. Enter person name, description, and amount
3. Select whether they owe you or you owe them
4. Choose the date
5. Tap Add

### Managing Debts
- **Swipe** on a debt to reveal quick actions
- **Long press** on a debt for context menu options
- Mark debts as completed when paid
- Edit existing debts by tapping Edit in the context menu

### Viewing Statistics
- Navigate to the Statistics tab
- View debt distribution in the pie chart
- Check your net balance and summary

### Changing Language
1. Go to Settings tab
2. Tap on Language
3. Select English or Russian
4. The app will update immediately

## Technical Details

- **Data Persistence**: Uses UserDefaults with Codable for local storage
- **Localization**: NSLocalizedString with .strings files
- **Charts**: Native SwiftUI Charts framework (iOS 16+)
- **Architecture**: MVVM pattern with ObservableObject
- **UI**: Pure SwiftUI with no UIKit dependencies

## License

This project is available for educational and personal use.