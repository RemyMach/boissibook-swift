//
//  GetBooks.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import Foundation

extension URLSession {
    fileprivate func handleBookFileResponse(_ data: Data, _ url: URL, _ completion: @escaping (Result<BookFileDto, Error>) -> Void) {
        do {
            print(url.absoluteString)
            let bookFiles = try JSONDecoder().decode(GetBookFilesRequest.self, from: data)
            print(bookFiles)
            if bookFiles.bookFiles.count > 0 {
                completion(.success(bookFiles.bookFiles[0]))
            } else {
                completion(.failure(NSError(domain: "No book file found", code: 404, userInfo: nil)))
            }
        } catch let decoderError {
            completion(.failure(decoderError))
        }
    }
    
    func getBookFile(at url: URL, completion: @escaping (Result<BookFileDto, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                self.handleBookFileResponse(data, url, completion)
            }
        }
        .resume()
    }

    fileprivate func handleBookDownload(_ bookFileTempUrl: URL, _ completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let bookData = try Data(contentsOf: bookFileTempUrl)
            completion(.success(bookData))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func downloadBook(at url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        self.downloadTask(with: url){
            (tempFileURL, response, error) in
            if let bookFileTempUrl = tempFileURL {
                self.handleBookDownload(bookFileTempUrl, completion)
            }
        }.resume()
    }
}
