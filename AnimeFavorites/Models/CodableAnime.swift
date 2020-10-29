//
//  CodableAnime.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

struct CodableAnime: Codable {
  var favorite = false
  let title: String
  let imageURL: String
  
  enum CodingKeys: String, CodingKey {
    case title
    case imageURL = "image_url"
  }
}

extension CodableAnime: Anime {
  var isFavorited: Bool {
    get {
      return self.favorite
    }
    set {
      self.favorite = newValue
    }
  }
  
  var imageURLString: String {
    return self.imageURL
  }
}
