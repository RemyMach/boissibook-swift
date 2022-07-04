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
    
    @State private var searchText = ""
    
    @State var books: [Book] = []
    
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
                    Text("Rechercher")
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
                                .onChange(of: searchText) { newValue in
                                    if(newValue.count > 3) {
                                        var urlComponents = URLComponents()
                                        urlComponents.scheme = "http"
                                        urlComponents.host = "boissibook.nospy.fr"
                                        urlComponents.path = "/book-search"
                                        urlComponents.queryItems = [
                                            URLQueryItem(name: "searchQuery", value: newValue)
                                        ]
                                        //let urlModify  = URL(string: "\(url)?searchQuery=\(newValue)")!
                                        URLSession.shared.searchBooks(at: urlComponents.url!) { result in
                                            switch result {
                                                case .success(let books):
                                                self.books = books.map {Book(
                                                    id: $0.id ,title: $0.title, authors: $0.authors ?? ["non connu"],
                                                    imageUrl: $0.imgUrl ?? "https://complianz.io/wp-content/uploads/2019/03/placeholder-705x474.jpg")}
                                                    print("success search books")
                                                    print(self.books)
                                                    break
                                                case .failure(let error):
                                                print("error search books -> \(String(describing: urlComponents.url))")
                                                    print(error)
                                                    break
                                          }
                                        }
                                    }
                                
                                }
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        List(books) { book in
                            BookCellViewAdd(book: book)
                        }
                        .listStyle(.plain)
                    }
                }
                Spacer()
            }
        }
    }
}

struct SearchBook_Previews: PreviewProvider {
    static var previews: some View {
        SearchBook()
    }
}
