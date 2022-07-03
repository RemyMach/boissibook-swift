//
//  ContentView.swift
//  Shared
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isOnboardingViewActive: Bool = true
    var body: some View {
        if isOnboardingViewActive {
            Home(isOnboardingViewActive: $isOnboardingViewActive)
            
        }else {
            TabMenu()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
