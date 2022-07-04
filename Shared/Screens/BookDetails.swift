//
//  BookDetails.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import SwiftUI

struct BookDetails: View {
    
    let book: Book;
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack() {
                    ZStack {
                        Image(systemName:"book.circle.fill")
                            .font(.system(size: 50, weight: .ultraLight))
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        }
                    VStack {
                        HStack {
                            Text(book.title)
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        HStack() {
                            Text("by \(book.authors.joined(separator: ", "))")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .frame(width: (screenWidth * 0.9) )
                .padding(.bottom, 10)
                Divider()
                    .frame(width: (screenWidth * 0.9) )
                Spacer()
                AsyncImage(url: URL(string: book.imageUrl)) { image in
                    image
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                } placeholder: {
                    Image("clean-code")
                        .resizable()
                        .scaledToFit()
                        .frame(width: (screenWidth * 0.8))
                }
                Text(book.description)
                Button("Ouvrir") {}
                    .frame(width: 48, height: 48)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Capsule().foregroundColor(Color(red: 0.0, green: 0.0, blue: 200.0, opacity: 0.2)))
                Spacer()
            }
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookDetails(book: Book(
            id: "1", title: "Clean Code", authors: ["martin Fowler"], imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api", description: "voici une description example"))
    }
}
