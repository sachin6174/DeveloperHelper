import Foundation
import SwiftUI

class DiskPermissionManager: ObservableObject {
    @Published var needsPermission = false

    func checkFullDiskPermission() -> Bool {
        let testFile = "/Library/.DeveloperHelperTest"
        do {
            try "test".write(toFile: testFile, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testFile)
            return true
        } catch {
            return false
        }
    }

    func requestPermission() {
        let url = URL(
            string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles")!
        NSWorkspace.shared.open(url)
    }
}
