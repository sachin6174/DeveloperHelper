import Foundation

final class FileOperationsService {
    // Singleton instance
    static let shared = FileOperationsService()
    
    // A private serial queue to handle deletion tasks one by one
    private let operationQueue = DispatchQueue(label: "com.developerhelper.FileOperationsQueue", qos: .userInitiated)
    
    // Private initializer prevents instantiation from outside
    private init() { }
    
    /// Deletes an item at the specified path using the provided admin credentials.
    /// - Parameters:
    ///   - adminUsername: Admin username.
    ///   - adminPassword: Admin password.
    ///   - itemPath: Path to the file or directory to delete.
    ///   - completion: Completion handler with a Bool indicating success.
    func deleteItem(adminUsername: String, adminPassword: String, itemPath: String, completion: @escaping (Bool) -> Void) {
        operationQueue.async {
            // Build the command using sudo.
            // WARNING: This approach is insecure because it exposes the admin password.
            let command = "echo '\(adminPassword)' | sudo -S -u \(adminUsername) rm -rf '\(itemPath)'"
            
            let process = Process()
            process.launchPath = "/bin/bash"
            process.arguments = ["-c", command]
            
            process.launch()
            process.waitUntilExit()
            
            let success = (process.terminationStatus == 0)
            completion(success)
        }
        
    }
}
