import Foundation

enum SidebarItem: String, CaseIterable, Identifiable {
    case fileManager = "File Manager"
    case appManager = "App Manager"
    // Add more cases here as needed

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .fileManager:
            return "folder"
        case .appManager:
            return "square.grid.2x2"
        @unknown default:
            return "questionmark"
        }
    }
}
