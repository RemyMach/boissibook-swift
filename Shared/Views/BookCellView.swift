//
//  BookCellView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import SwiftUI

struct BookCellView: View {
    
    let book: Book;
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)
            } placeholder: {
                Image("clean-code")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)
            }
            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                    .padding(.trailing, 12)
                    .allowsTightening(true)
                    .lineLimit(1)
                Text(book.authors.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 12)
                    .allowsTightening(true)
                    .lineLimit(1)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)

        }
        .padding(16)
        .background(Color.white)
    }
}

struct BookCellView_Previews: PreviewProvider {
    static var previews: some View {
        let imageUrl = "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api";
        BookCellView(book: Book(
            id: "1",
            title: "Clean Code",
            authors: ["martin Fowler"],
            imageUrl: imageUrl,
            description: "description example"
        ))
    }
}
