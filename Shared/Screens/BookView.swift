//
//  BookView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 01/07/2022.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        ZStack {
            Image("clean-code")
                .resizable()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("En détail".uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundColor(.gray)
                    Text("Clean Code")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text("Pomme")
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                Spacer()
                HStack {
                    Image("clean-code")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                    VStack(alignment: .leading) {
                        Text("Clean Code")
                            .bold()
                        Text("Martin Fowler")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button("Details".uppercased()) {}
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 8)
                    .background(Capsule().foregroundColor(Color(white: 0, opacity: 0.2)))

                }
                .padding(16)
                .background(Color.white)
            }
        }
        .cornerRadius(20)
        .aspectRatio(3/4, contentMode: .fit)
        .padding()
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
            
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
