//
//  ImageCache.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation
import UIKit

final class ImageCache {
  static let shared = ImageCache()
  
  private let cache = NSCache<NSString, NSData>()
  
  private init() { }
  
  func saveImage(_ imageData: Data, with url: String) {
    self.cache.setObject(imageData as NSData, forKey: url as NSString)
  }
  
  func getImage(from urlString: String) -> Data? {
    return self.cache.object(forKey: urlString as NSString) as Data?
  }
}
