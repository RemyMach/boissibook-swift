//
//  BooksHome.swift
//  boissibook
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct BooksHome: View {
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Livres")
                    .font(.system(size:40))
                    .fontWeight(.heavy)
                Spacer()
            }
        }
    }
}

struct BooksHome_Previews: PreviewProvider {
    static var previews: some View {
        BooksHome()
    }
}
