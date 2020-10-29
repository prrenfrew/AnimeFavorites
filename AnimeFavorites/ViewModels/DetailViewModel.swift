//
//  DetailViewModel.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

protocol DetailViewModel {
  func isFavorited() -> Bool
  func name() -> String
  func getImageData(completion: @escaping (Data?) -> Void)
}
