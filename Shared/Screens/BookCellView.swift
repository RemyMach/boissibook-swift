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
            Image("clean-code")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                Text(book.authors.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button("Details".uppercased()) {}
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Capsule().foregroundColor(Color(white: 0, opacity: 0.2)))

        }
        .padding(16)
        .background(Color.white)
    }
}

struct BookCellView_Previews: PreviewProvider {
    //@State static var book: Book = Book(title: "Clean Code")

    static var previews: some View {
        //BookCellView(book: $book)
        BookCellView(book: Book(title: "Clean Code", authors: ["martin Fowler"]))
    }
}
