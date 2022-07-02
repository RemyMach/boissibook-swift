//
//  ContentView.swift
//  Shared
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    var body: some View {
        if isOnboardingViewActive {
            Home()
            
        }else {
            BooksHome()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
