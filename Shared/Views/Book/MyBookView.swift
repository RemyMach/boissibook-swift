//
//  MyBookView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 26/07/2022.
//

import SwiftUI

struct MyBookView: View {
    
    let book: Book
    
    var body: some View {
        AsyncImage(url: URL(string: book.imageUrl)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding(.horizontal, 10)
        } placeholder: {
            Image("clean-code")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 10)
        }
        .aspectRatio(4/3, contentMode: .fill)
    }
}

struct MyBookView_Previews: PreviewProvider {
    static var previews: some View {
        MyBookView(book: Book(
            id: "1",
            title: "Clean Code",
            authors: ["martin Fowler"],
            imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api",
            description: "voici une description example"
        ))
    }
}
