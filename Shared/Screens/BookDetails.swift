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
            ScrollView {
                VStack(spacing: 10) {
                    HStack() {
                        VStack {
                            HStack {
                                Text(book.title)
                                    .font(.system(size:25))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            HStack() {
                                Text("par \(book.authors.joined(separator: ", "))")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            Spacer()
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
                            .scaledToFit()
                            .frame(height: (screenHeight * 0.4))
                            .cornerRadius(12)
                    } placeholder: {
                        Image("clean-code")
                            .resizable()
                            .scaledToFit()
                            .frame(height: (screenHeight * 0.4))
                    }
                    Text(book.description)
                        .font(.system(size: 14, weight: .light))
                        .frame(width: (screenWidth * 0.9) )
                    Button("Ouvrir") {}
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookDetails(book: Book(
            id: "1", title: "Clean Code", authors: ["martin Fowler"], imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api", description: "voici une description example"))
    }
}
