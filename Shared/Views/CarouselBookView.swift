//
//  CarouselBookView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 09/07/2022.
//

import SwiftUI

struct CarouselBookView: View {
    
    let book: Book;
    
    let scale: CGFloat;
    let rectangleOverlay: some View = RoundedRectangle(cornerRadius: 8)
        .stroke(Color(white: 0.4));
    var imagePlaceholder: some View {
        Image("clean-code")
        .resizable()
        .frame(width: 160)
        .scaledToFill()
        .clipped()
        .cornerRadius(8)
        .overlay(rectangleOverlay)
        .shadow(radius: 3)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: book.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 160)
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(8)
                    .overlay(rectangleOverlay)
                    .shadow(radius: 3)
            } placeholder: {
                imagePlaceholder
            }
            Text(book.title)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            HStack(spacing: 0) {
            }.padding(.top, -4)
        }

    .scaleEffect(.init(width: scale, height: scale))
    .onAppear() {
        withAnimation(.easeOut(duration: 1)) {}
    }
    .padding(.vertical)
    }
}

struct CarouselBookView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselBookView(
            book: Book(
                id: "1",
                title: "Clean Code",
                authors: ["martin Fowler"],
                imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api",
                description: "voici une description example"
            ),
            scale: 12
        )
    }
}
