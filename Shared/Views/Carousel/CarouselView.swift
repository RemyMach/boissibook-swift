//
//  CarouselView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 06/07/2022.
//

import SwiftUI

struct Movie: Hashable {
    let title, imageName: String
}

struct CarouselView: View {
    
    @Binding var books: [Book];
    
    @State private var bookFiles: [BookFile] = [];
    
    @AppStorage("booksFiles") var booksFileStorage: Data?;
    
    init(books: Binding<[Book]>, title: String) {
        self.title = title;
        _books = books;
        do {
            if booksFileStorage != nil {
                let bookFilesDecoded = try JSONDecoder().decode([BookFile].self, from: booksFileStorage!)
                _bookFiles = State(initialValue: bookFilesDecoded)
            }
        } catch {
            print("error in decode bookFileStorage stringify")
            print(error)
        }
    }
    
    let title : String;
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                Spacer()
            }
            Carousel(books: $books, bookFiles: $bookFiles)
        }
        .padding(.vertical, 20)
        
    }
}

struct CarouselView_Previews: PreviewProvider {
    @State static var books: [Book] = []
    static var previews: some View {
        CarouselView(books: $books, title: "Récents")
    }
}
