import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text(authManager.userProfile?.name ?? "Swimmer")
                                .font(.headline)
                            Text(authManager.userProfile?.email ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Swimming Profile")) {
                    NavigationLink(destination: GoalsView()) {
                        Label("Goals", systemImage: "target")
                    }
                    
                    NavigationLink(destination: AchievementsView()) {
                        Label("Achievements", systemImage: "medal")
                    }
                }
                
                Section(header: Text("Account")) {
                    Button(action: { showingEditProfile = true }) {
                        Label("Edit Profile", systemImage: "pencil")
                    }
                    
                    Button(action: authManager.signOut) {
                        Label("Sign Out", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
    }
}