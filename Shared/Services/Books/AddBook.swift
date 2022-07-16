//
//  AddBook.swift
//  boissibook
//
//  Created by Rémy Machavoine on 04/07/2022.
//

import Foundation


struct AddBooksBodyDto: Encodable {
    let apiId: String
}

extension URLSession {
    fileprivate func initUrlComponents() -> URLComponents {
        // MARK: URL Components
        var components = URLComponents()
        components.scheme = "https"
        components.host = "boissibook.nospy.fr"
        components.path = "/books"
        return components
    }
    
    fileprivate func createUrlRequest(url: URL, apiId: String) -> URLRequest? {
        // MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //MARK: POST Request V.1.0
        let body = AddBooksBodyDto(apiId: apiId)
        
        guard let jsonBody = try? JSONEncoder().encode(body) else {
            print("Invalid httpBody")
            return nil
        }
        
        // MARK: Set httpBody
        request.httpBody = jsonBody
        
        return request
    }
    
    fileprivate func handleResponse(_ error: Error?, _ data: Data?, _ completionHandler: @escaping (Result<String, Error>) -> Void) {
        if let error = error {
            completionHandler(.failure(error))
        }
        if data != nil {
            do {
                completionHandler(.success("the book has been added"))
            }
        } else {
            completionHandler(.success("no data"))
            print("No Data")
        }
    }
    
    func addBooks(withId apiId: String,completionHandler: @escaping (Result<String, Error>) -> Void) {
        let components = initUrlComponents()
        //MARK: Create URL
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        if let request = createUrlRequest(url: url, apiId: apiId) {
            self.dataTask(with: request) {
                data, response, error in
                self.handleResponse(error, data, completionHandler)
            }.resume()
        }
    }
}
