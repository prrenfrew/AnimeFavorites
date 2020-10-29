//
//  Searcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

protocol Searcher {
  func search(with term: String, completion: @escaping ([Anime]) -> Void)
}
