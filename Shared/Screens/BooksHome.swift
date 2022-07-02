//
//  BooksHome.swift
//  boissibook
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct Book : Identifiable {
    let id = UUID()
    let title: String;
}

struct BooksHome: View {
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State private var searchText = ""
    
    @State var books = [
        Book(title: "Clean Code"),
        Book(title: "Clean Craft"),
        Book(title: "Boissinot") ,
        Book(title: "Rust"),
        Book(title: "Une pomme est jaune"),
        Book(title: "tu es qui ?"),
        Book(title: "Australie"),
        Book(title: "Torture")
    ]

    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack() {
                    ZStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                        Image(systemName: "circle")
                            .font(.system(size: 50, weight: .ultraLight))
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        }
                    Text("Bibliothèque")
                        .font(.system(size:40))
                        .fontWeight(.heavy)
                    Spacer()
                }
                .frame(width: (screenWidth * 0.9) )
                .padding(.bottom, 10)
                Divider()
                    .frame(width: (screenWidth * 0.9) )
                NavigationView {
                    VStack {
                        Text("Searching for \(searchText)")
                            .searchable(text:$searchText)
                            .navigationBarTitleDisplayMode(.inline)
                        List {
                            ForEach(searchText == "" ? books: books.filter { $0.title.contains(searchText)}, id: \.id) { book in
                                BookCellView(book: book)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                Spacer()
            }
        }
    }
}

struct BooksHome_Previews: PreviewProvider {
    static var previews: some View {
        BooksHome()
    }
}
