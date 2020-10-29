//
//  CoreDataUpdater.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation
import CoreData

final class CoreDataUpdater: Updater {
  func updateModel(anime: Anime) {
    guard let managedObject = anime as? NSManagedObject else { return }
    if anime.isFavorited {
      CoreDataManager.shared.insertObject(managedObject)
    } else {
      CoreDataManager.shared.deleteObject(managedObject)
    }
  }
}
