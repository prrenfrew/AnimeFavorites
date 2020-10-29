//
//  CodableAnimeToAnimeModelAdapter.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation
import CoreData

class CodableAnimeToAnimeModelAdapter {
  private let codableAnime: CodableAnime
  
  init(anime: CodableAnime) {
    self.codableAnime = anime
  }
  
  func convert() -> AnimeModel? {
    let model = CoreDataManager.shared.createNewObject(objectType: AnimeModel.self, shouldInsertIntoContext: false) { animeModel in
      animeModel.favorite = self.codableAnime.favorite
      animeModel.animeTitle = self.codableAnime.title
      animeModel.animeImageURLString = self.codableAnime.imageURL
    }
    return model
  }
}
