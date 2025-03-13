import SwiftUI

struct AppManagerView: View {
    var body: some View {
        VStack {
            Text("App Manager")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Add a list to show installed applications
            List {
                Section("Installed Applications") {
                    Text("Feature coming soon...")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .navigationTitle("App Manager")
    }
}

#Preview {
    AppManagerView()
}
