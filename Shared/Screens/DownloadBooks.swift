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
    
    init() {
        do {
            let booksDecoded = try JSONDecoder().decode([Book].self, from: booksStorage)
            _books = State(initialValue: booksDecoded)
        } catch {
            print("error in decode booStorage")
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    /*HStack() {
                        VStack {
                            HStack {
                                Text("Livres disponibles")
                                    .font(.system(size:25))
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            HStack() {
                                Text("à la lecture")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width: (screenWidth * 0.9) )
                    .padding(.bottom, 10)
                    Divider()
                        .frame(width: (screenWidth * 0.9) )
                    Spacer()*/
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(books, id: \.id) { book in
                            NavigationLink(destination: BookDetails(book: book)) {
                                    VStack {
                                        ZStack {
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "ellipsis")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 14, height: 14, alignment: .leading)
                                                        .padding(.horizontal, 15)
                                                        .rotationEffect(.degrees(90))
                                                        .foregroundColor(.gray)
                                                }
                                                Spacer()
                                            }
                                            AsyncImage(url: URL(string: book.imageUrl)) { image in
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
                                       
                                        ZStack {
                                            Text(book.title)
                                                .font(.system(size: 10, weight: .bold))
                                                .minimumScaleFactor(0.90)
                                                .allowsTightening(true)
                                                .lineLimit(1)
                                                .padding(.horizontal, 30)
                                            HStack {
                                                Spacer()
                                                Image(systemName: "ellipsis")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 14, height: 14, alignment: .leading)
                                                    .padding(.horizontal, 15)
                                            }
                                        }
                                        HStack {
                                            Text("par \(book.authors.joined(separator: ", "))")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(.gray)
                                                .allowsTightening(true)
                                                .lineLimit(1)
                                                .padding(.horizontal, 30)
                                        }
                                    }
                                
                            }
                                .accentColor(.black)
                        }
                        .contextMenu {
                            Text("plgdkbm")
                        }
                    }.padding(.horizontal)
                }
            }
            .navigationTitle("Livres disponibles")
            .padding(.vertical, 30)
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DownloadBooks_Previews: PreviewProvider {
    static var previews: some View {
        DownloadBooks()
    }
}
