//
//  ReloadBooksToastView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 26/07/2022.
//

import SwiftUI

struct ReloadBooksToastView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "clock")
                Text("Recharger votre bibliothèque pour voir l'ajout")
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

struct ReloadBooksToastView_Previews: PreviewProvider {
    static var previews: some View {
        ReloadBooksToastView()
    }
}
