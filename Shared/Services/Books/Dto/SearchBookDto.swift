//
//  SearchBookDto.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import Foundation

struct SearchBooksDtoRequest: Decodable {
    let books: [SearchBookDto]
}

struct SearchBookDto: Decodable {
    let id: String
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
