//
//  BookCellViewAdd.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import SwiftUI

struct BookCellViewAdd: View {
    let book: Book;
    let addIcon: some View = Image(systemName: "plus.circle")
        .resizable()
        .scaledToFit()
        .frame(width: 25, height: 25)
        .foregroundColor(.blue);
    let placeholderImage: some View = Image("clean-code")
        .resizable()
        .frame(width: 48, height: 48)
        .cornerRadius(12);
    
    
    fileprivate func addBooks() {
        URLSession.shared.addBooks(withId:book.id) { result in
            switch result {
            case .success(let message):
                print("book added with success" + message)
                break
            case .failure(let error):
                print("error when add book")
                print(error)
                break
            }
        }
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)
            } placeholder: {
                placeholderImage
            }
            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                Text(book.authors.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 12)
            Spacer()
            Button(action: {
                print("add book")
                addBooks()
            }) {
                addIcon
            }
            .buttonStyle(.plain)

        }
        .padding(16)
        .background(Color.white)
    }
}

struct BookCellViewAdd_Previews: PreviewProvider {
    static var previews: some View {
        BookCellViewAdd(
            book: Book(
                id: "1",
                title: "Clean Code",
                authors: ["martin Fowler"],
                imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api",
                description: "description example"
            )
        )
    }
}


