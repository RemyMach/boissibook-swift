//
//  BookDetails.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import SwiftUI

enum BookAvailability {
    case NotAvailable;
    case Available;
    case Downloading;
}

struct BookDetails: View {

    @State var url: URL? = nil;
    @State var bookFileUrl: URL? = nil;

    let book: Book;
    @State private var isShowingBook = false;
    let reviews = [
        BookReview(id: "as", img: "avatar-0", username: "Swann HERRERA", content: "Lorem ipsum dolor sit atme etas"),
        BookReview(id: "we", img: "avatar-1", username: "Flav", content: "lorem dolor site atme")
    ];

    @State private var bookAvailability: BookAvailability = BookAvailability.NotAvailable;

    @State private var bookFile: BookFile? = nil;
    
    @State private var requestIsLoading: Bool = false;
    
    @AppStorage("booksFiles") var booksFileStorage: Data?;

    let screenWidth = UIScreen.main.bounds.size.width

    let screenHeight = UIScreen.main.bounds.size.height

    fileprivate func reviewCard(review: BookReview) -> some View {
        return HStack(alignment: .top) {
            Image(review.img)
                .resizable()
                .cornerRadius(5)
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(review.username)
                    .foregroundColor(Color.yellow)
                    .fontWeight(Font.Weight.bold)
                Text(review.content)
            }
        }
        .padding(12)
        .background(LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.16, green: 0.28, blue: 0.35),
            Color(red: 0.98, green: 0.43, blue: 0.79)
        ]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .fixedSize(horizontal: true, vertical: true)
    }
    
    func openBook() {}
    
    
    func addBookFileToStorage(bookFile: BookFile) {
        do {
            if booksFileStorage != nil {
                guard var booksFilesDecoded = try? JSONDecoder().decode([BookFile].self, from: booksFileStorage!) else {
                    print("error in decode booksFileStorage")
                    return
                }
                print(booksFilesDecoded)
                booksFilesDecoded.removeAll(where: { $0.bookId == bookFile.bookId })
                booksFilesDecoded.append(bookFile)
                print(booksFilesDecoded)
                guard let bookFilesEncode = try? JSONEncoder().encode(booksFilesDecoded) else {
                    print("error in encode bookFile")
                    return
                }
                self.bookFile = bookFile
                booksFileStorage = bookFilesEncode
            } else {
                guard let bookFilesEncode = try? JSONEncoder().encode([bookFile]) else {
                    print("error in encode bookFile")
                    return
                }
                booksFileStorage = bookFilesEncode
            }
            bookAvailability = BookAvailability.Available
        } catch {
            print("error in add book to file storage")
            print(error)
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    HStack() {
                        VStack {
                            HStack {
                                Text(book.title)
                                        .font(.system(size: 25))
                                        .fontWeight(.heavy)
                                Spacer()
                            }
                            HStack() {
                                Text("par \(book.authors.joined(separator: ", "))")
                                        .foregroundColor(.gray)
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width: (screenWidth * 0.9))
                    .padding(.bottom, 10)
                    Divider()
                    .frame(width: (screenWidth * 0.9))
                    Spacer()
                    AsyncImage(url: URL(string: book.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: (screenHeight * 0.4))
                            .cornerRadius(12)
                    } placeholder: {
                        Image("clean-code")
                            .resizable()
                            .scaledToFit()
                            .frame(height: (screenHeight * 0.4))
                    }
                    if let description = book.description.htmlAttributedString() {
                        UIKLabel(description, maxWidth: screenWidth * 0.8)
                        .padding()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(reviews, id: \.id) { review in
                                reviewCard(review: review)
                            }
                        }
                    }.padding(.horizontal)
                    if bookAvailability == BookAvailability.Downloading {
                        // Loading spinner button
                        HStack {
                            Spacer()
                            LoadingView()
                            Spacer()
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                    } else if bookAvailability == BookAvailability.Available {
                        Button(action: {
                            isShowingBook.toggle()
                        }) {
                            Text("Lire")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .sheet(isPresented: $isShowingBook) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isShowingBook = false
                                }) {
                                    Text("Fermer")
                                }
                                .padding(6)
                                .buttonStyle(.borderless)
                            }.padding(EdgeInsets(top: 5, leading: 10, bottom: -4, trailing: 10))
                            PdfBookView(data: bookFile!.bookData!)
                        }
                        
                    } else if bookAvailability == BookAvailability.Available {
                        Button("Obtenir") {
                            bookAvailability = BookAvailability.Downloading
                            URLSession.shared.downloadBook(at: bookFileUrl!) { result in
                                switch result {
                                case .success(let data):
                                    self.bookFile?.bookData = data
                                    bookAvailability = BookAvailability.Available
                                    addBookFileToStorage(bookFile: bookFile!)
                                case .failure(let error):
                                    bookAvailability = BookAvailability.NotAvailable
                                    print("error in downloadBook")
                                    print(error)
                                }
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle(radius: 20))
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                        } else {
                            LoadingView()
                        }
                        
                    } else {
                        Text("Pas de téléchargement disponible")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                url = URL(string: "http://boissibook.nospy.fr/book-files/book/\(book.id)")!
                do {
                    if booksFileStorage != nil {
                        let booksFilesDecoded = try JSONDecoder().decode([BookFile].self, from: booksFileStorage!)
                        bookFile = booksFilesDecoded.first(where: { $0.bookId == book.id })
                        if bookFile != nil {
                            bookAvailability = BookAvailability.Available
                        }
                    }
                } catch {
                    print("error in decode booksFileStorage")
                    print(error)
                }

                if bookFile == nil {
                    URLSession.shared.getBookFile(at: url!) { result in
                        switch result {
                        case .success(let bookFile):
                            self.bookFile = BookFile(id: bookFile.id, bookId: book.id)
                            self.bookFileUrl = URL(string: "http://boissibook.nospy.fr/book-files/\(bookFile.id)/download")
                        case .failure(let error):
                            print("Error when get book files from API")
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookDetails(book: Book(
            id: "1",
            title: "Clean Code",
            authors: ["martin Fowler"],
            imageUrl: "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api",
            description: "voici une description example"
        ))
    }
}
