import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .fileManager

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
                    AppManagerView()  // Replace the placeholder Text view
                }
            } else {
                Text("Select an item")
            }
        }
    }
}

#Preview {
    ContentView()
}
