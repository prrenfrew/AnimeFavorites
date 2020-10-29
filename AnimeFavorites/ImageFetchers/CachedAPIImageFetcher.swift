//
//  CachedAPIImageFetcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

final class CachedAPIImageFetcher: ImageFetcher {
  
  private let apiFetcher: APIImageFetcher
  
  init(session: Session = URLSession.shared) {
    self.apiFetcher = APIImageFetcher(session: session)
  }
  
  func getImage(with urlString: String, completion: @escaping (Data?) -> Void) {
    if let cachedImageData = ImageCache.shared.getImage(from: urlString) {
      completion(cachedImageData)
    } else {
      self.apiFetcher.getImage(with: urlString) { (data) in
        if let data = data {
          ImageCache.shared.saveImage(data, with: urlString)
        }
        completion(data)
      }
    }
  }
}
