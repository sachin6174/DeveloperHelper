import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .fileManager
    @State private var showLogin = false
    @StateObject private var diskPermissionManager = DiskPermissionManager()

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
        .alert("Full Disk Access Required", isPresented: $diskPermissionManager.needsPermission) {
            Button("Open Settings") {
                diskPermissionManager.requestPermission()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(
                "This app requires full disk access to manage files. Please enable it in System Settings."
            )
        }
        .onAppear {
            checkLoginStatus()
            checkDiskPermission()
        }
    }

    private func checkLoginStatus() {
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")

        if username == nil || password == nil {
            showLogin = true
        }
    }

    private func checkDiskPermission() {
        if !diskPermissionManager.checkFullDiskPermission() {
            diskPermissionManager.needsPermission = true
        }
    }
}

#Preview {
    ContentView()
}
