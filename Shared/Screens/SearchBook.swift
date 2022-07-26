//
//  SearchBook.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import SwiftUI

struct SearchBook: View {
    
    @AppStorage("booksFromHome") var booksStorage: Data = Data();
    
    @ObservedObject var networkManager = NetworkManager()
    
    @State var downloaded = false
    
    let url = URL(string: "http://boissibook.nospy.fr/book-search")!
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    @StateObject var searchText = DebounceObject()
    
    @State private var requestIsLoading: Bool = false;
    
    @State private var isAddLoad: Bool = false
    
    @State var booksOwned: [Book] = []
    
    @State var books: [Book] = []
    
    @State private var isShowingToast = false
    
    init() {
        do {
            let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
            _booksOwned = State(initialValue: booksDecoded)
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    func generateConformView(book: Binding<Book>) -> some View {
        let bookOwned = booksOwned.contains(where: { $0.title == book.wrappedValue.title })
        self.downloaded = bookOwned
        print(bookOwned)
        print(book.wrappedValue.title)
        return BookCellViewAdd(downloaded: bookOwned, book: book)
    }
    
    
    //TODO mettre un hitorique de recherche ?
    var body: some View {
        ZStack {
            NavigationView {
                    VStack {
                        if (self.requestIsLoading) {
                            HStack {
                                Spacer()
                                LoadingView()
                                Spacer()
                            }
                        }
                        HStack {
                            Spacer()
                        }
     
                        if(books.count > 0) {
                            let booksBind = $books
                            List(booksBind) { book in
                                generateConformView(book: book)
                            }.listStyle(.plain)
                        } else {
                            VStack {
                                Text("Rechercher un livre par son Titre pour l'ajouter")
                                Spacer()
                            }
                        }
                    }.searchable(text: $searchText.text, prompt: "Rechercher un livre à ajouter")
                        .navigationTitle("Rechercher")
                        .navigationBarTitleDisplayMode(.large)
                        .onChange(of: searchText.debouncedText) { newValue in
                            if(newValue.count > 3) {
                                var urlComponents = URLComponents()
                                urlComponents.scheme = "http"
                                urlComponents.host = "boissibook.nospy.fr"
                                urlComponents.path = "/book-search"
                                urlComponents.queryItems = [
                                    URLQueryItem(name: "searchQuery", value: newValue)
                                ]
                                self.requestIsLoading = true
                                URLSession.shared.searchBooks(at: urlComponents.url!) { result in
                                    switch result {
                                        case .success(let books):
                                            self.books = books.map {Book(
                                                id: $0.id ,title: $0.title, authors: $0.authors ?? ["non connu"],
                                                imageUrl: $0.imgUrl ?? "https://complianz.io/wp-content/uploads/2019/03/placeholder-705x474.jpg",
                                                description: $0.description)}
                                            print("success search books")
                                            self.requestIsLoading = false
                                            break
                                        case .failure(let error):
                                        print("error search books -> \(String(describing: urlComponents.url))")
                                            isShowingToast = true
                                            self.requestIsLoading = false
                                            break
                                  }
                                }
                            }
                        
                }
            }.onChange(of: booksStorage, perform: { newBooksStorage in
                do {
                    let bookFilesDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
                    self.booksOwned = bookFilesDecoded
                } catch {
                    print("error in decode bookFileStorage stringify")
                    print(error)
                }
            })
            
            Spacer()
        }.toast(isShowing: $isShowingToast, status: "Error")
            .toast(isShowing: $networkManager.isDisconnected, status:"Network_Problem")
    }
}


struct SearchBook_Previews: PreviewProvider {
    static var previews: some View {
        SearchBook()
    }
}
