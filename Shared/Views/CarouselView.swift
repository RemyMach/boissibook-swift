//
//  CarouselView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 06/07/2022.
//

import SwiftUI

struct Movie: Hashable {
    let title, imageName: String
}

struct CarouselView: View {
    
    let books: [Book];
    
    let title : String;
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                Spacer()
            }
            Carousel(books: books)
        }
        .padding(.vertical, 20)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(books: [], title: "Récents")
    }
}
