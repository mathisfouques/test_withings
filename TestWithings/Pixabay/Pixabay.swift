//
//  Pixabay.swift
//  TestWithings
//
//  Created by Mathis Fouques on 26/11/2021.
//

import UIKit

struct PixabaySearchResult: Codable {
    struct Hit: Codable {
        let id: Int
        let largeImageURL: URL
        let previewURL: URL
    }
    let hits: [Hit]
}

class Pixabay {
    private static let baseURL = "https://pixabay.com/api/"
    
    static func search(_ searchQuery: String, completionHandler: @escaping (Result<[PixabayImage], ImageSearchError>) -> Void) {
        let escapedQuery = searchQuery.replacingOccurrences(of: " ", with: "+")
                                      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var requestURL = URLComponents(string: baseURL)!
        requestURL.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: escapedQuery),
            URLQueryItem(name: "safesearch", value: "true"),
            URLQueryItem(name: "per_page", value: "200")
        ]
        
        let task = URLSession.shared.dataTask(with: requestURL.url!) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(error)))
                }
                return
            }
            
            guard response != nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknownResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknownResponse))
                }
                return
            }

            guard let hits = try? JSONDecoder().decode(PixabaySearchResult.self, from: data).hits else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.decodingError))
                }
                return
            }
            
            let photos: [PixabayImage] = hits.compactMap() { hit in
                return PixabayImage(id: hit.id, thumbnailURL: hit.previewURL, largeImageURL: hit.largeImageURL)
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(photos))
            }
        }
        task.resume()
    }
}

enum ImageSearchError: Error {
    case error(Error), unknownResponse, decodingError
}
