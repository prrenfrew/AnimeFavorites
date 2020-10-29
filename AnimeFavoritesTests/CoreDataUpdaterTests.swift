//
//  CoreDataUpdaterTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class CoreDataUpdaterTests: XCTestCase {
  
  var sut: CoreDataUpdater!
  
  override func setUpWithError() throws {
    self.sut = CoreDataUpdater()
  }
  
  override func tearDownWithError() throws {
    self.sut = nil
    CoreDataManager.shared.context.rollback()
  }
  
  func testFavoritedAnimeIsAddedToContext() throws {
    let newAnime = try self.createNewAnime()
    XCTAssertEqual(CoreDataManager.shared.context.insertedObjects.count, 0)
    self.sut.updateModel(anime: newAnime)
    XCTAssertEqual(CoreDataManager.shared.context.insertedObjects.count, 1)
  }
  
  func testPreviouslyFavoritedThenUnfavoritedIsNotOnContext() throws {
    var newAnime = try self.createNewAnime()
    XCTAssertEqual(CoreDataManager.shared.context.insertedObjects.count, 0)
    self.sut.updateModel(anime: newAnime)
    XCTAssertEqual(CoreDataManager.shared.context.insertedObjects.count, 1)
    newAnime.isFavorited = false
    self.sut.updateModel(anime: newAnime)
    XCTAssertEqual(CoreDataManager.shared.context.deletedObjects.count, 1)
  }
  
  private func createNewAnime() throws -> Anime {
    let newAnime = CoreDataManager.shared.createNewObject(objectType: AnimeModel.self, shouldInsertIntoContext: false) { (anime) in
      anime.animeImageURLString = "url"
      anime.animeTitle = "title"
      anime.favorite = true
    }
    let unwrappedAnime = try XCTUnwrap(newAnime)
    return unwrappedAnime
  }
}
