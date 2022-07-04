//
//  BookDto.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import Foundation

struct GetBooksDtoRequest: Decodable {
    let books: [BookDto]
}

struct BookDto: Decodable {
    let id: String
    let apiId: String
    let title: String
    let authors: Optional<[String]>
    let publisher: Optional<String>
    let publishedDate: Optional<String>
    let description: String
    let isbn13: String
    let language: String
    let imgUrl: Optional<String>
    let pages: Int
}
