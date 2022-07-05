//
//  BooksHome.swift
//  boissibook
//
//  Created by Rémy Machavoine on 30/06/2022.
//

import SwiftUI

struct BooksHome: View {
    let url = URL(string: "http://boissibook.nospy.fr/books")!
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State private var searchText = ""
    
    @State private var requestIsLoading: Bool = false;
    
    @State var books: [Book] = []

    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(searchText == "" ? books: books.filter { $0.title.contains(searchText)}, id: \.id) { book in
                            NavigationLink(destination: BookDetails(book: book)) {
                                BookCellView(book: book)
                            }
                                .accentColor(.black)
                            }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        requestIsLoading = true;
                        URLSession.shared.getBooks(at: url) { result in
                            switch result {
                                case .success(let books):
                                    self.requestIsLoading = false;
                                    self.books = books.map {Book(
                                        id: $0.apiId,
                                        title: $0.title, authors: $0.authors ?? ["non connu"],
                                        imageUrl: $0.imgUrl ?? "https://complianz.io/wp-content/uploads/2019/03/placeholder-705x474.jpg", description: $0.description)}
                                    print("on passe bien ici")
                                    print(self.books)
                                    break
                                case .failure(let error):
                                    print("error when get books")
                                    print(error)
                                    self.requestIsLoading = false;
                                    break
                          }
                        }
                    }
                }.searchable(text:$searchText)
                .navigationTitle("Bibliothèque")
                .navigationBarTitleDisplayMode(.large)
                Spacer()
            }
            if (self.requestIsLoading) {
                LoadingView()
            }
        }
    }
}


struct BooksHome_Previews: PreviewProvider {
    static var previews: some View {
        BooksHome()
    }
}
