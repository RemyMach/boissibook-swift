//
//  DownloadBooks.swift
//  boissibook
//
//  Created by Rémy Machavoine on 05/07/2022.
//

import SwiftUI

struct DownloadBooks: View {
    
    @State var books: [Book] = [];
    
    @AppStorage("booksFromHome") var booksStorage: Data = Data();
    
    let columns = [
            GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    let ellipsis: some View = Image(systemName: "ellipsis")
        .resizable()
        .scaledToFit()
        .frame(width: 10, height: 10, alignment: .leading)
        .padding(.horizontal, 15)
        .rotationEffect(.degrees(90))
        .foregroundColor(.gray)
    
    
    @State var detailsWantedBook: Book? = nil
    @State var detailsWanted = false

    init() {
        do {
            let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
            _books = State(initialValue: booksDecoded)
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    fileprivate func displayImage(_ book: Book) -> some View {
        return AsyncImage(url: URL(string: book.imageUrl)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding(.horizontal, 10)
        } placeholder: {
            Image("clean-code")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 10)
        }
        .aspectRatio(4/3, contentMode: .fill)
    }
    
    fileprivate func recentBook() -> some View {
        return CarouselView(books: books, title: "Récents")
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .white,
                        Color(red: 0.95, green: 0.95, blue: 0.95)
                    ]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            )
            .padding(.top, 15)
    }
    
    fileprivate func displayDetailButton(book) -> Button<Text> {
        return Button("Details") {
            detailsWantedBook = book
            detailsWanted = true
        }
    }
    
    fileprivate func displayMenu(_ book: Book) -> Menu<some View, Button<Text>> {
        return Menu {
            displayDetailButton(book)
        } label: {
            ellipsis
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                        .padding(.horizontal, 20)
                    recentBook()
                    VStack {
                        HStack {
                            Text("Livres disponibles")
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(books, id: \.id) { book in
                                VStack {
                                    ZStack {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                displayMenu(book)
                                            }
                                            if let book = detailsWantedBook {
                                                NavigationLink(destination: BookDetails(book: book), isActive: $detailsWanted) {
                                                    EmptyView()
                                                }
                                            }
        
                                            Spacer()
                                        }
                                        displayImage(book)
                                    }

                                    Text(book.title)
                                        .font(.system(size: 15, weight: .bold))
                                        .minimumScaleFactor(0.90)
                                        .allowsTightening(true)
                                        .lineLimit(1)
                                        .padding(.horizontal, 30)

                                    HStack {
                                        Text("par \(book.authors.joined(separator: ", "))")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.gray)
                                            .allowsTightening(true)
                                            .lineLimit(1)
                                            .padding(.horizontal, 30)
                                    }
                                }.contextMenu {
                                    displayDetailButton(book)
                                }
                            }
                        }
                    }
                    .navigationTitle("Mes livres")
                        .padding(.vertical, 30)
                        .padding(.horizontal)
                }
                
            }
        }
    }
}

struct DownloadBooks_Previews: PreviewProvider {
    static var previews: some View {
        DownloadBooks()
    }
}
