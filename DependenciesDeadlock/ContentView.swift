//
//  ContentView.swift
//  DependenciesDeadlock
//
//  Created by Oron Ben Zvi on 29/05/2024.
//

import SwiftUI
import Dependencies

struct ContentView: View {
    let fooQueue = DispatchQueue(label: "foo", qos: .utility)
    
    @State var myMessage = "N/A"
    
    var body: some View {
        VStack {
            Text(myMessage)
        }
        .padding()
        .onAppear {
            deadlock()
        }
    }
    
    func deadlock() {
        fooQueue.async {
            @Dependency(\.message) var message
            print("foo", message.read())
        }
        
        (0..<10000).forEach { num in
            // long process
            _ = num
        }
        
        @Dependency(\.message) var message
        myMessage = message.read()
    }
}

#Preview {
    ContentView()
}
