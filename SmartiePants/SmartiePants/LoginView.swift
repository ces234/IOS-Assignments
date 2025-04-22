import SwiftUI
import SwiftData

enum Destination: Hashable {
    case bottomBar
}

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionManager
    
    @Query var users: [User]
    @State private var path = NavigationPath()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func handleLogin() {
        if let found = users.first(where: { $0.username == username }) {
            // set the current user
            session.currentUser = found
            path.append(Destination.bottomBar)
        } else {
            alertMessage = "Username not found. Please sign up first."
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                Text("Smartie Pants?")
                    .font(.poppins(fontStyle: .largeTitle, fontWeight: .bold))
                    .foregroundStyle(.darkBlue)
                
                VStack(spacing: 16) {
                    Text("Welcome Back")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.poppins(fontStyle: .title2, fontWeight: .semibold))
                    TextField("Username", text: $username)
                        .textFieldStyle(.plain)
                        .padding().background(.gray.opacity(0.2))
                        .cornerRadius(8)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.plain)
                        .padding().background(.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: BottomBarView()) {
                            
                        }
                        Button("Log In") {
                            handleLogin()
                        }
                        .font(.poppins(fontStyle: .headline, fontWeight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.darkBlue))
                        .foregroundColor(.white)
                    }
                }
                .padding()
                Spacer()
            }
            .padding()
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(for: Destination.self) { dest in
                switch dest {
                case .bottomBar:
                    BottomBarView()
                        .environmentObject(session)   // pass the session
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
