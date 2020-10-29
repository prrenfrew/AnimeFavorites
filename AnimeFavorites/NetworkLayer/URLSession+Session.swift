//
//  URLSession+Session.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

extension URLSession: Session {
  func getData(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
    do {
      let url = try self.createURLIfPossible(from: urlString)
      self.dataTask(with: url) { (data, _, error) in
        completion(data, error)
      }.resume()
    } catch {
      completion(nil, error)
    }
  }
  
  private func createURLIfPossible(from string: String) throws -> URL {
    guard let url = URL(string: string) else {
      throw NetworkError.invalidURL
    }
    return url
  }
}
