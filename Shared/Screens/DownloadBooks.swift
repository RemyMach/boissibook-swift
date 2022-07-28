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
    
    @State private var bookFiles: [BookFile] = [];
    
    @AppStorage("booksFiles") var booksFileStorage: Data?;
    
    @State private var sheetPresented = false
    
    let columns = [
            GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State var detailsWantedBook: Book? = nil
    @State var detailsWanted = false
    @State var bookFileState: BookFile? = nil

    init() {
        do {
            if booksFileStorage != nil {
                let bookFilesDecoded = try JSONDecoder().decode([BookFile].self, from: booksFileStorage!)

                _bookFiles = State(initialValue: bookFilesDecoded)
            }
        } catch {
            print("error in decode bookFileStorage stringify")
            print(error)
        }
        
        do {
            let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
            _books = State(initialValue: booksDecoded)
            
            let result = books.filter { book in
                let bookFileFind = bookFiles.first(where: {$0.bookId == book.id})
                return bookFileFind != nil && bookFileFind?.bookData != nil
              }
            _books = State(initialValue: result)
            print("c'est les books")
            print(books)
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    func getBookFile(book: Book) -> some View {
        //let book = self.books[$0]
        let bookFile =  self.bookFiles.first(where: {$0.bookId == book.id})
        
        return PdfBookView(data: bookFile!.bookData!)
        
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                        .padding(.horizontal, 20)
                    CarouselView(books: $books, title: "Récents")
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
                    VStack {
                        HStack {
                            Text("Livres disponibles")
                                .font(.system(size:25))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(books, id: \.id) { book in
                                let bookFile = self.bookFiles.first(where: {$0.bookId == book.id})
                                //self.bookFileState = bookFile
                                    
                                VStack {
                                    ZStack {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Menu {
                                                    Button("Details") {
                                                        detailsWantedBook = book
                                                        detailsWanted = true
                                                    }
                                                } label: {
                                                    Image(systemName: "ellipsis")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 10, height: 10, alignment: .leading)
                                                        .padding(.horizontal, 15)
                                                        .rotationEffect(.degrees(90))
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            
                                            if let book = detailsWantedBook {
                                                NavigationLink(destination: BookDetails(book: book), isActive: $detailsWanted) {
                                                    EmptyView()
                                                }
                                            }
                                            Spacer()
                                        }
             
                                        Button(action:  {
                                            sheetPresented = true
                                            self.bookFileState = bookFile
                                        }) {
                                            //Text(bookFile!.bookId)
                                            MyBookView(book: book)
                                        }
                                        
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
                                    Button("Details") {
                                        detailsWantedBook = book
                                        detailsWanted = true
                                    }
                                }
                            
                            }.sheet(item: self.$bookFileState) { book in
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.sheetPresented = false
                                        //getBookFile(book: self.books[$0])
                                    }) {
                                        Text("Fermer")
                                    }
                                    .padding(6)
                                    .buttonStyle(.borderless)
                                }.padding(EdgeInsets(top: 5, leading: 10, bottom: -4, trailing: 10))
                               
                                PdfBookView(data: book.bookData!)
                            }
                        }
                    }
                    .navigationTitle("Mes livres")
                        .padding(.vertical, 30)
                        .padding(.horizontal)
                }
                .onChange(of: booksStorage, perform: { newBookStorage in
                    do {
                        let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
                        self.books = booksDecoded
                    } catch {
                        print("error in decode booStorage")
                        print(error)
                    }
                })
                .onChange(of: booksFileStorage, perform: { newBooksFileStorage in
                    do {
                        if booksFileStorage != nil {
                            let bookFilesDecoded = try JSONDecoder().decode([BookFile].self, from: booksFileStorage!)
                            self.bookFiles = bookFilesDecoded
                        }
                        
                        
                    } catch {
                        print("error in decode bookFileStorage stringify")
                        print(error)
                    }
                    
                    do {
                        let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
                        
                        
                        let result = booksDecoded.filter { book in
                            let bookFileFind = bookFiles.first(where: {$0.bookId == book.id})
                            return bookFileFind != nil && bookFileFind?.bookData != nil
                          }
                        self.books = result
                        print("c'est les books refresh")
                        print(books)
                    } catch {
                        print("error in decode booStorage in refresh")
                        print(error)
                    }
                })
            }
        }
    }
}

struct DownloadBooks_Previews: PreviewProvider {
    static var previews: some View {
        DownloadBooks()
    }
}
