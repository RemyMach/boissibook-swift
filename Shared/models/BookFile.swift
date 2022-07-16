//
// Created by Nospy on 06/07/2022.
//

import Foundation

public struct BookFile: Identifiable, Codable {
    public let id: String;
    public let bookId: String;
    public var bookData: Data?
}