//
//  BooksHome.swift
//  boissibook
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct Book : Identifiable {
    let id: String;
    let title: String;
    let authors: [String]
    let imageUrl: String;
}

struct BooksHome: View {
    let url = URL(string: "http://boissibook.nospy.fr/books")!
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State private var searchText = ""
    
    @State var books: [Book] = []
    
    /*@State var books = [
        Book(title: "Clean Code"),
        Book(title: "Clean Craft"),
        Book(title: "Boissinot") ,
        Book(title: "Rust"),
        Book(title: "Une pomme est jaune"),
        Book(title: "tu es qui ?"),
        Book(title: "Australie"),
        Book(title: "Torture")
    ]*/

    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack() {
                    ZStack {
                        Image(systemName: "house")
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
                        HStack {
                            Text("Recherche pour")
                            Text("\(searchText)")
                                .foregroundColor(.blue)
                                .searchable(text:$searchText)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        List {
                            ForEach(searchText == "" ? books: books.filter { $0.title.contains(searchText)}, id: \.id) { book in
                                BookCellView(book: book)
                            }
                        }
                        .listStyle(.plain)
                        .onAppear {
                            URLSession.shared.getBooks(at: url) { result in
                                switch result {
                                    case .success(let books):
                                        self.books = books.map {Book(
                                            id: $0.apiId,
                                            title: $0.title, authors: $0.authors ?? ["non connu"],
                                        imageUrl: $0.imgUrl ?? "https://complianz.io/wp-content/uploads/2019/03/placeholder-705x474.jpg")}
                                        print("on passe bien ici")
                                        print(self.books)
                                        break
                                    case .failure(let error):
                                        print("error when get books")
                                        print(error)
                                        break
                              }
                            }
                        }
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
