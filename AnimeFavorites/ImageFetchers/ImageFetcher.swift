//
//  ImageFetcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

protocol ImageFetcher {
  func getImage(with urlString: String, completion: @escaping (Data?) -> Void)
}
