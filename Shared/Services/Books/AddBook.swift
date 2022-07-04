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
    func addBooks(at url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        /*self.dataTask(with: url) { (data, response, error) in
          if let error = error {
            completion(.failure(error))
          }

          if let data = data {
            do {
              print(data)
              completion(.success("the request is a success"))
            } catch let decoderError {
              completion(.failure(decoderError))
            }
          }
        }.resume()*/
    }
            
    func addBooksV2(withId apiId: String,completionHandler: @escaping (Result<String, Error>) -> Void) {
                
        // MARK: URL Components
        var components = URLComponents()
        components.scheme = "https"
        components.host = "boissibook.nospy.fr"
        components.path = "/books"
        
        
        //MARK: Create URL
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        // MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //MARK: POST Request V.1.0
        let addBooksBodyDto = AddBooksBodyDto(apiId: apiId)
        
        guard let httpBody = try? JSONEncoder().encode(addBooksBodyDto) else {
            print("Invalid httpBody")
            return
        }
        
        // MARK: Set httpBody
        request.httpBody = httpBody
        
        self.dataTask(with: request) {
            data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            if let data = data {
                do {
            
                    completionHandler(.success("the book has been added"))
                    
                }catch(let error) {
                    print(error.localizedDescription)
                }
            } else {
                completionHandler(.success("no data"))
                print("No Data")
            }
        }.resume()
    }
}
