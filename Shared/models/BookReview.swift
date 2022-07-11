//
//  BookReview.swift
//  boissibook
//
//  Created by Swann HERRERA on 11/07/2022.
//

import Foundation

public struct BookReview : Identifiable, Codable {
    public var id: String;
    public let img: String;
    public let username: String;
    public let content: String;
}
