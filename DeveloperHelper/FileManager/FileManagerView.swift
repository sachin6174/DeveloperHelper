import SwiftUI

struct FileItem: Identifiable {
    let id = UUID()
    let path: String
    var name: String {
        (path as NSString).lastPathComponent
    }
    var isDirectory: Bool {
        var isDir: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
        return isDir.boolValue
    }
}

struct FileManagerView: View {
    @State private var files = [
        FileItem(path: "/Users/sachinkumar/Library/Developer/Xcode/DerivedData"),
        FileItem(path: "/Library/Application Support/SureMDMNixMac/components/launchhd/loadlau.sh"),
    ]

    private func openItem(_ item: FileItem) {
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""

        if item.isDirectory {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: item.path)
        } else {
            NSWorkspace.shared.openFile(item.path)
        }
    }

    private func deleteItem(_ item: FileItem) {
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""

        let process = Process()
        process.launchPath = "/usr/bin/sudo"
        process.arguments = ["rm", "-rf", item.path]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()

            if process.terminationStatus == 0 {
                if let index = files.firstIndex(where: { $0.id == item.id }) {
                    files.remove(at: index)
                }
            } else {
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                if let output = String(data: data, encoding: .utf8) {
                    print("Error: \(output)")
                }
                throw NSError(
                    domain: "FileManager", code: Int(process.terminationStatus), userInfo: nil)
            }
        } catch {
            print("Error deleting file: \(error)")
        }
    }

    var body: some View {
        List(files) { file in
            HStack {
                Text(file.name)
                Spacer()
                Button("Open") {
                    openItem(file)
                }
                .buttonStyle(.bordered)

                Button("Delete") {
                    deleteItem(file)
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("File Manager")
    }
}

#Preview {
    FileManagerView()
}
