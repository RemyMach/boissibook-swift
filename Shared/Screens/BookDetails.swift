//
//  BookDetails.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import SwiftUI

struct BookDetails: View {

    let book: Book;
    let reviews = [
        BookReview(id: "as", img: "avatar-0", username: "Swann HERRERA", content: "Lorem ipsum dolor sit atme etas"),
        BookReview(id: "we", img: "avatar-1", username: "Flav", content: "lorem dolor site atme")
    ];

    let screenWidth = UIScreen.main.bounds.size.width

    let screenHeight = UIScreen.main.bounds.size.height

    fileprivate func reviewCard(review: BookReview) -> some View {
        return HStack(alignment: .top) {
            Image(review.img)
                .resizable()
                .cornerRadius(5)
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(review.username)
                    .foregroundColor(Color.yellow)
                    .fontWeight(Font.Weight.bold)
                Text(review.content)
            }
        }
        .padding(12)
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.16, green: 0.28, blue: 0.35),
            Color(red: 0.98, green: 0.43, blue: 0.79)
        ]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .fixedSize(horizontal: true, vertical: true)
    }
    
    func openBook() {}
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    HStack() {
                        VStack {
                            HStack {
                                Text(book.title)
                                        .font(.system(size: 25))
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
                            .frame(width: (screenWidth * 0.9))
                            .padding(.bottom, 10)
                    Divider()
                            .frame(width: (screenWidth * 0.9))
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
                    if let description = book.description.htmlAttributedString() {
                        UIKLabel(description, maxWidth: screenWidth * 0.8)
                                .padding()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(reviews, id: \.id) { review in
                                reviewCard(review: review)
                            }
                        }
                    }.padding(.horizontal)
                    
                    
                    Button(action: openBook) {
                        Text("Lire").padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .frame(height: 48)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    
                    
                    
                    
//                    HStack {
//
//                    }
//                    .padding()
//                    .padding(.horizontal)
//                    .background(Color.yellow)
//                    .frame(maxHeight: .infinity, alignment: .bottom)
//                    .edgesIgnoringSafeArea(.bottom)

                    

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
