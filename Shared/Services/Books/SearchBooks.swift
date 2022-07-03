//
//  SearchBooks.swift
//  boissibook
//
//  Created by Rémy Machavoine on 03/07/2022.
//

import Foundation

extension URLSession {
    func searchBooks(at url: URL, completion: @escaping (Result<[SearchBookDto], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
          if let error = error {
            completion(.failure(error))
          }

          if let data = data {
            do {
              print(data)
              let books = try JSONDecoder().decode(SearchBooksDtoRequest.self, from: data)
              completion(.success(books.books))
            } catch let decoderError {
              completion(.failure(decoderError))
            }
          }
        }.resume()
    }
}

