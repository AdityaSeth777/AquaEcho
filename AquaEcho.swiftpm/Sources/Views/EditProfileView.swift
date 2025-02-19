import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthenticationManager
    
    @State private var name: String
    @State private var preferredStroke: UserProfile.StrokeStyle
    @State private var poolLength: Int
    
    init() {
        _name = State(initialValue: UserDefaults.standard.string(forKey: "userName") ?? "")
        _preferredStroke = State(initialValue: UserProfile.StrokeStyle(rawValue: UserDefaults.standard.string(forKey: "preferredStroke") ?? "freestyle") ?? .freestyle)
        _poolLength = State(initialValue: UserDefaults.standard.integer(forKey: "poolLength"))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    
                    Picker("Preferred Stroke", selection: $preferredStroke) {
                        ForEach(UserProfile.StrokeStyle.allCases, id: \.self) { stroke in
                            Text(stroke.rawValue.capitalized)
                                .tag(stroke)
                        }
                    }
                }
                
                Section(header: Text("Pool Settings")) {
                    Picker("Pool Length", selection: $poolLength) {
                        Text("25 meters").tag(25)
                        Text("50 meters").tag(50)
                        Text("25 yards").tag(25)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveProfile()
                    dismiss()
                }
            )
        }
    }
    
    private func saveProfile() {
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(preferredStroke.rawValue, forKey: "preferredStroke")
        UserDefaults.standard.set(poolLength, forKey: "poolLength")
    }
}