//
//  SnapCarousel.swift
//  boissibook
//
//  Created by Rémy Machavoine on 06/07/2022.
//

import SwiftUI

struct Carousel: View {
    
    @Binding var books: [Book]
    
    @Binding var bookFiles: [BookFile]
    
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
//        guard let rootView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController?.view else { return 1}
        let midPoint: CGFloat = 125
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(books, id: \.id) { book in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        let bookFile = self.bookFiles.first(where: {$0.bookId == book.id})
                        //TODO mettre les résultats inverse quand on aura un storage de ce qui est téléchargé
                        if(bookFiles.contains(where: {$0.id == book.id})) {
                            NavigationLink(
                                destination: CarouselBookView(book: book, bookFile: bookFile, scale: scale), //calculateTheDestinationView(book: book, scale: scale),
                               label: {
                                   CarouselBookView(book: book, bookFile: bookFile, scale: scale)
                                })
                        } else {
                            CarouselBookView(book: book,bookFile: bookFile, scale: scale)
                        }
                            
                    }
                    .frame(width: 125, height: 290)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }
                Spacer()
                    .frame(width: 16)
            }
        }
    }
    
    func calculateTheDestinationView(book: Book, scale: CGFloat) -> AnyView {
        let bookFile = self.bookFiles.first(where: {$0.bookId == book.id})
        if(bookFile != nil && bookFile?.bookData != nil) {
            let data = bookFile?.bookData
            if(data != nil) {
                //return AnyView(PdfBookView(data: data! ))
            }
        }
        return AnyView(CarouselBookView(book: book,bookFile: nil, scale: scale))
    }
        
}

struct MovieDetailsView: View {
    
    let book: Book
    
    var body: some View {
        Image(book.imageUrl)
            .resizable()
            .scaledToFill()
            .navigationTitle(book.title)
    }
}


struct Carousel_Previews: PreviewProvider {
    @State static var bookFiles: [BookFile] = []
    @State static var books: [Book] = []
    static var previews: some View {
        Carousel(books: $books, bookFiles: $bookFiles)
    }
}

