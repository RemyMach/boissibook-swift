//
//  SnapCarousel.swift
//  boissibook
//
//  Created by Rémy Machavoine on 06/07/2022.
//

import SwiftUI

struct Carousel: View {
    
    @State var books: [Book]
    
    @State var booksDownloads: [Book] = []
    
    @AppStorage("booksFromHome") var booksStorage: Data?
    
    init(books: [Book]) {
        self.books = books
        do {
            if booksStorage != nil {
                let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage!)
                _booksDownloads = State(initialValue: booksDecoded)
            }
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    
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
        /*HStack {
            Text(categoryName)
                .font(.system(size: 14, weight: .heavy))
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(2)
            Spacer()
        }.padding(.horizontal)
        .padding(.top)*/

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                        ForEach(books, id: \.id) { book in
                            GeometryReader { proxy in
                                let scale = getScale(proxy: proxy)
                                
                                //TODO mettre les résultats inverse quand on aura un storage de ce qui est téléchargé
                                if(booksDownloads.contains(where: {$0.id == book.id})) {
                                    NavigationLink(
                                       destination: BookDetails(book: book),
                                       label: {
                                           CarouselBookView(book: book, scale: scale)
                                        })
                                } else {
                                    CarouselBookView(book: book, scale: scale)
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
    static let moviesGen: [Movie] = [
        .init(title: "Wonder Woman 1984", imageName: "clean-code"),
        .init(title: "Avatar", imageName: "clean-code"),
        .init(title: "Captain Marvel", imageName: "clean-code"),
        .init(title: "Soul", imageName: "clean-code"),
        .init(title: "Tenet", imageName: "clean-code"),
        .init(title: "Avengers: Endgame", imageName: "clean-code"),
    ]
    static var previews: some View {
        Carousel(books: [])
    }
}
