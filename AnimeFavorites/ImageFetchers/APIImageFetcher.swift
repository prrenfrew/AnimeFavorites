//
//  APIImageFetcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

final class APIImageFetcher: ImageFetcher {
  
  private let session: Session
  
  init(session: Session = URLSession.shared) {
    self.session = session
  }
  
  func getImage(with urlString: String, completion: @escaping (Data?) -> Void) {
    self.session.getData(urlString: urlString) { (data, _) in
      completion(data)
    }
  }
}
