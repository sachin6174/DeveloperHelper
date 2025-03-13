import SwiftUI

struct LoginView: View {
    @Binding var isPresented: Bool
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Developer Helper Login")
                .font(.title)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Login") {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                isPresented = false
            }
            .disabled(username.isEmpty || password.isEmpty)
        }
        .frame(width: 300, height: 250)
    }
}
