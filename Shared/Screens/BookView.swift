//
//  BookView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 01/07/2022.
//

import SwiftUI

struct BookElementList {
    let title: String;
}

struct BookView: View {
    
    let bookElement: BookElementList
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("clean-code")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                    VStack(alignment: .leading) {
                        Text(bookElement.title)
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
        Text("")
    }
}
