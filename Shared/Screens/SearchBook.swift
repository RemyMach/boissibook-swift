//
//  SearchBook.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import SwiftUI

struct SearchBook: View {
    
    let url = URL(string: "http://boissibook.nospy.fr/book-search")!
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    //@State private var searchText = @StateObject var debounceObject = DebounceObject()
    
    @StateObject var searchText = DebounceObject()
    
    @State private var requestIsLoading: Bool = false;
    
    @State var books: [Book] = []
    
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
                        List(books) { book in
                            BookCellViewAdd(book: book)
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
                                        print(self.books)
                                        self.requestIsLoading = false
                                        break
                                    case .failure(let error):
                                    print("error search books -> \(String(describing: urlComponents.url))")
                                        print(error)
                                        self.requestIsLoading = false
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


struct SearchBook_Previews: PreviewProvider {
    static var previews: some View {
        SearchBook()
    }
}
