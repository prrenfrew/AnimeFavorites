//
//  Anime.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

protocol Anime {
  var isFavorited: Bool { get set }
  var title: String { get }
  var imageURLString: String { get }
}
