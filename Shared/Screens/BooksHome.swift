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
    
    @State var books: [Book] = []
    
    @State private var searchText = ""
    
    @State private var requestIsLoading: Bool = false;
    
    @AppStorage("booksFromHome") var booksStorage: Data = Data();
    
    init() {
        let table = [0, 1, 2, 3, 4]
        let ou = table[2...4]
        print(ou)
        for i in 0..<2 {
            print(i)
        }
        do {
            let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
            _books = State(initialValue: booksDecoded)
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List {
                        if (self.requestIsLoading) {
                            HStack {
                                Spacer()
                                LoadingView()
                                Spacer()
                            }
                        }
                        if(books.count > 0) {
                            ForEach(searchText == "" ? books: books.filter { $0.title.contains(searchText)}, id: \.id) { book in
                                NavigationLink(destination: BookDetails(book: book)) {
                                    BookCellView(book: book)
                                }
                                    .accentColor(.black)
                                }
                        }else {
                            VStack {
                                Spacer()
                                Text("Vous n'avez pas encore de livre")
                                Spacer()
                            }
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
                                        id: $0.id,
                                        title: $0.title, authors: $0.authors ?? ["non connu"],
                                        imageUrl: $0.imgUrl ?? "https://complianz.io/wp-content/uploads/2019/03/placeholder-705x474.jpg", description: $0.description)}
                                    
                                    guard let booksEncode = try? JSONEncoder().encode(self.books) else {
                                        print("Invalid encode books")
                                        return
                                    }
                                    print("get book home request success")
                                    self.booksStorage = booksEncode
                                    print(self.booksStorage)
                                    //print(self.books)
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
        }
    }
}


struct BooksHome_Previews: PreviewProvider {
    static var previews: some View {
        BooksHome()
    }
}
