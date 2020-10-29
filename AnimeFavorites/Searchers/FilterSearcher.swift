//
//  FilterSearcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

final class FilterSearcher: Searcher {
  
  private let originalArray: [Anime]
  
  init(array: [Anime]) {
    self.originalArray = array
  }
  
  func search(with term: String, completion: @escaping ([Anime]) -> Void) {
    if term.isEmpty {
      completion(self.originalArray)
    } else {
      completion(
        self.originalArray.filter { $0.title.contains(term) }
      )
    }
  }
}
