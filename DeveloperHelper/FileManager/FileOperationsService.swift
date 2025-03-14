//
//  FileOperations.swift
//  DeveloperHelper
//
//  Created by sachin kumar on 14/03/25.
//

import Foundation

func deleteItem(adminUsername: String, adminPassword: String, itemPath: String) -> Bool {
    // Build the shell command using sudo.
    // The command echoes the admin password to sudo (-S) and runs the rm command.
    // WARNING: This approach is insecure because it exposes the admin password.
    let command = "echo '\(adminPassword)' | sudo -S -u \(adminUsername) rm -rf '\(itemPath)'"
    
    let process = Process()
    process.launchPath = "/bin/bash"
    process.arguments = ["-c", command]
    
    process.launch()
    process.waitUntilExit()
    
    return process.terminationStatus == 0
}
