//
//  ErrorToastView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 26/07/2022.
//

import SwiftUI

struct ErrorToastView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "network")
                Text("Erreur serveur recommencez plus tard")
                    .font(.footnote)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
        }
        .padding()
    }
}

struct ErrorToastView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorToastView()
    }
}
