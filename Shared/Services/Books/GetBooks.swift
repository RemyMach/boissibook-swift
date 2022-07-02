//
//  GetBooks.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import Foundation

extension URLSession {
    func getBooks(at url: URL, completion: @escaping (Result<[BookDto], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
          if let error = error {
            completion(.failure(error))
          }

          if let data = data {
            do {
              print(data)
              let books = try JSONDecoder().decode(GetBooksDto.self, from: data)
              completion(.success(books.books))
            } catch let decoderError {
              completion(.failure(decoderError))
            }
          }
        }.resume()
    }
}
