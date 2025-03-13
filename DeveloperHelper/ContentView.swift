import SwiftUI

struct ContentView: View {
    @State private var selectedItem: String?

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selectedItem)
        } detail: {
            DetailView(selectedItem: selectedItem)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct SidebarView: View {
    @Binding var selection: String?

    var body: some View {
        List(["Item 1", "Item 2", "Item 3"], id: \.self, selection: $selection) { item in
            Text(item)
        }
        .listStyle(.sidebar)
    }
}

struct DetailView: View {
    let selectedItem: String?

    var body: some View {
        if let selectedItem {
            Text("Details for \(selectedItem)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Text("Select an item from sidebar")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
