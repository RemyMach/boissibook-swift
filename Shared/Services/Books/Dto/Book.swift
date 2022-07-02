//
//  Book.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import Foundation

struct GetBooksDto: Decodable {
    let books: [BookDto]
}

struct BookDto: Decodable {
    let id: String
    let apiId: String
    let title: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let isbn13: String
    let language: String
    let imgUrl: String
    let pages: Int
}

/*"id": "f0d1ddd8-df0a-433c-ad3d-521cf9019258",
      "apiId": "4JvFjE4dlGMC",
      "title": "Les misérables",
      "authors": [
        "Victor Hugo"
      ],
      "publisher": "Livre de Poche Jeunesse",
      "publishedDate": "2014-08-13",
      "description": "Le destin de Jean Valjean, forçat échappé du bagne, est bouleversé par sa rencontre avec Fantine. Mourante et sans le sou, celle-ci lui demande de prendre soin de Cosette, sa fille confiée aux Thénardier. Ce couple d’aubergistes, malhonnête et sans scrupules, exploitent la fillette jusqu’à ce que Jean Valjean tienne sa promesse et l’adopte. Cosette devient alors sa raison de vivre. Mais son passé le rattrape et l’inspecteur Javert le traque...",
      "isbn13": "9782013235006",
      "language": "fr",
      "imgUrl": "http://books.google.com/books/content?id=4JvFjE4dlGMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72a0sty87mX89qFzThmMep58LL-21RmYul2uCeEmvFvdUF_lUmgh2uWGFi1TSSUvLSxRQ94YzlGimUzKMFIlHAzryMchKmYJOpdYtC6atb9qHx5VnQcBLWkzWxLQfbwDJO73Osk&source=gbs_api",
      "pages": 352*/

