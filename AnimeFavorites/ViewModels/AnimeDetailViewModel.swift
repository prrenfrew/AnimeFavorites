//
//  AnimeDetailViewModel.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

final class AnimeDetailViewModel: DetailViewModel {
  
  private var anime: Anime
  private let imageFetcher: ImageFetcher
  
  init(anime: Anime,
       imageFetcher: ImageFetcher = CachedAPIImageFetcher()) {
    self.anime = anime
    self.imageFetcher = imageFetcher
  }
  
  func isFavorited() -> Bool {
    return self.anime.isFavorited
  }
  
  func name() -> String {
    return self.anime.title
  }
  
  func getImageData(completion: @escaping (Data?) -> Void) {
    self.imageFetcher.getImage(with: self.anime.imageURLString, completion: completion)
  }
}
