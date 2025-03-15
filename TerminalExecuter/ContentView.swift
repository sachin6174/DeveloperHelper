//
//  ContentView.swift
//  TerminalExecuter
//
//  Created by sachin kumar on 14/03/25.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: TerminalExecuterDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(TerminalExecuterDocument()))
}
