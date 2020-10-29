//
//  AnimeModel+CoreDataProperties.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//
//

import Foundation
import CoreData


extension AnimeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimeModel> {
        return NSFetchRequest<AnimeModel>(entityName: "AnimeModel")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var animeTitle: String?
    @NSManaged public var animeImageURLString: String?

}

extension AnimeModel : Identifiable {

}

extension AnimeModel: Anime {
  var isFavorited: Bool {
    get {
      return self.favorite
    }
    set {
      self.favorite = newValue
    }
  }
  
  var title: String {
    return self.animeTitle ?? ""
  }
  
  var imageURLString: String {
    return self.animeImageURLString ?? ""
  }
  
  
}
