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
    
    @AppStorage("booksFromHome") var booksStorage: Data?
    
    init() {
        do {
            if booksStorage != nil {
                let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage!)
                _books = State(initialValue: booksDecoded)
            }
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                        .padding(.horizontal, 20)
                    if (self.requestIsLoading) {
                        HStack {
                            Spacer()
                            LoadingView()
                            Spacer()
                        }
                    }
                    if(self.searchText == "") {
                        CarouselView(books: books, title: "Populaire")
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.white, Color(red: 0.95, green: 0.95, blue: 0.95)]), startPoint: .center, endPoint: .bottom))
                            .padding(.top, 5) 
                    }
                    VStack {
                        HStack {
                            Text("Toute la Bibliothèque")
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                                .padding(.horizontal, 15)
                                .padding(.top, 30)
                            Spacer()
                        }
                        LazyVStack {
                            if(books.count > 0) {
                                ForEach(searchText == "" ? books: books.filter { $0.title.contains(searchText)}, id: \.id) { book in
                                    Divider().padding(.horizontal, 15)
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
                                    // print(self.booksStorage)
                                    // print(self.books)
                                    break
                                case .failure(let error):
                                    print("error when get books")
                                    print(error)
                                    self.requestIsLoading = false;
                                    break
                          }
                        }
                    }
                    .searchable(text:$searchText, prompt: "Rechercher dans la biliothèque")
                    .navigationTitle("Bibliothèque")
                        .navigationBarTitleDisplayMode(.large)
                        Spacer()
               }
                    
            }
        }
    }
}


struct BooksHome_Previews: PreviewProvider {
    static var previews: some View {
        BooksHome()
    }
}
