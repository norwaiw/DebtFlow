import SwiftUI

struct SettingsScreen: View {
    @AppStorage("selectedLanguage") private var selectedLanguage = "en"
    @State private var showingLanguagePicker = false
    
    private let appVersion = "1.0.0"
    
    var body: some View {
        NavigationView {
            Form {
                // Language Section
                Section(header: Text("settings.preferences")) {
                    HStack {
                        Text("settings.language")
                        Spacer()
                        Text(currentLanguageName)
                            .foregroundColor(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showingLanguagePicker = true
                    }
                }
                
                // About Section
                Section(header: Text("settings.about")) {
                    HStack {
                        Text("settings.version")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("settings.title")
            .sheet(isPresented: $showingLanguagePicker) {
                LanguagePickerView(selectedLanguage: $selectedLanguage)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var currentLanguageName: String {
        switch selectedLanguage {
        case "en":
            return NSLocalizedString("settings.english", comment: "")
        case "ru":
            return NSLocalizedString("settings.russian", comment: "")
        default:
            return NSLocalizedString("settings.english", comment: "")
        }
    }
}

struct LanguagePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedLanguage: String
    
    let languages = [
        ("en", "settings.english"),
        ("ru", "settings.russian")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(languages, id: \.0) { code, nameKey in
                    HStack {
                        Text(NSLocalizedString(nameKey, comment: ""))
                        Spacer()
                        if selectedLanguage == code {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedLanguage = code
                        UserDefaults.standard.set([code], forKey: "AppleLanguages")
                        UserDefaults.standard.synchronize()
                        dismiss()
                    }
                }
            }
            .navigationTitle("settings.language")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("form.cancel") {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}