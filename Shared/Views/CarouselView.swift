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
    
    //let Books: [Book];
    let topMovies: [Movie] = [
            .init(title: "Clean Code", imageName: "clean-code"),
            .init(title: "Clean Code", imageName: "clean-code"),
            .init(title: "Clean Code", imageName: "clean-code"),
            .init(title: "Clean Code", imageName: "clean-code"),
            .init(title: "Clean Code", imageName: "clean-code"),
            .init(title: "Clean Code", imageName: "clean-code"),
        ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Récents")
                    .font(.system(size:20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                Spacer()
            }
            Carousel(categoryName: "Top Movies of 2020", movies: topMovies)
        }
        .padding(.vertical, 20)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
