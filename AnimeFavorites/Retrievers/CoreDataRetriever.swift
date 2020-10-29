//
//  CoreDataRetriever.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation
import CoreData

final class CoreDataRetriever: Retriever {
  func retrieve(completion: @escaping ([Anime]) -> Void) {
    let animes = CoreDataManager.shared.getAllObjects(objectType: AnimeModel.self)
    completion(animes)
  }
}
