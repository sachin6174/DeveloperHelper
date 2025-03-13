import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .fileManager
    @State private var showLogin = false

    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, selection: $selectedItem) { item in
                NavigationLink(value: item) {
                    Label(item.rawValue, systemImage: item.icon)
                }
            }
            .navigationTitle("Developer Helper")
        } detail: {
            if let selected = selectedItem {
                switch selected {
                case .fileManager:
                    FileManagerView()
                case .appManager:
                    AppManagerView()
                }
            } else {
                Text("Select an item")
            }
        }
        .sheet(isPresented: $showLogin) {
            LoginView(isPresented: $showLogin)
        }
        .onAppear {
            checkLoginStatus()
        }
    }

    private func checkLoginStatus() {
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")

        if username == nil || password == nil {
            showLogin = true
        }
    }
}

#Preview {
    ContentView()
}
