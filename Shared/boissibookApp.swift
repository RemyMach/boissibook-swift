//
//  boissibookApp.swift
//  Shared
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

@main
struct boissibookApp: App {
    
    @State var message: String? = nil
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if let message = message {
                    Text(message)
                        .transition(.slide)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {}
            }
        }
    }
}
