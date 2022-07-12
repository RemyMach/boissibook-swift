//
// Created by Nospy on 06/07/2022.
//

import Foundation

struct BookFileDto: Decodable {
    let id: String
    let name: String
    let type: String
    let bookId: String
    let userId: String
    let downloadCount: Int
}

struct GetBookFilesRequest: Decodable {
    let bookFiles: [BookFileDto]
}