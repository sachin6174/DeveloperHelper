import SwiftUI

struct FileManagerView: View {
    var body: some View {
        VStack {
            Text("File Manager")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .navigationTitle("File Manager")
    }
}

#Preview {
    FileManagerView()
}
