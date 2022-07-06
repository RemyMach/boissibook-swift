//
//  LoadingView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 05/07/2022.
//

import SwiftUI

struct LoadingView: View {
    @State private var value: Double = 50
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1)
            
            /*ProgressView("Loading...", value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(1)
                .padding(.vertical, 10)*/
            //Text("Loading...")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
