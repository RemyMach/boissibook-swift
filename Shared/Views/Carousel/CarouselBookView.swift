//
//  CarouselBookView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 09/07/2022.
//

import SwiftUI

struct CarouselBookView: View {
    
    let book: Book;
    
    let bookFile: BookFile?;
    
    @State private var sheetPresented = false
    
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
            if(bookFile != nil) {
                Button(action:  {
                    sheetPresented = true
                }) {
                   CarouselElement(book: book)
                }.sheet(isPresented: $sheetPresented) {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.sheetPresented = false
                        }) {
                            Text("Fermer")
                        }
                        .padding(6)
                        .buttonStyle(.borderless)
                    }.padding(EdgeInsets(top: 5, leading: 10, bottom: -4, trailing: 10))
                    PdfBookView(data: bookFile!.bookData!)
                }
            }else {
                NavigationLink(destination: BookDetails(book: book)) {
                    CarouselElement(book: book)
                } .accentColor(.black)
            }
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
            bookFile: nil,
            scale: 12
        )
    }
}
