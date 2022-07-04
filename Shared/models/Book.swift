//
//  Book.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import Foundation

public struct Book : Identifiable {
    public let id: String;
    public let title: String;
    public let authors: [String]
    public let imageUrl: String;
    public let description: String;
}
