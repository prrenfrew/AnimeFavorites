//
//  AdapterTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class AdapterTests: XCTestCase {

  func testAdapterSuccessfullyConverts() throws {
    let codableAnime = CodableAnime(favorite: true, title: "title", imageURL: "imageURL")
    let adapter = CodableAnimeToAnimeModelAdapter(anime: codableAnime)
    let animeModel = try XCTUnwrap(adapter.convert())
    XCTAssertEqual(animeModel.animeImageURLString, codableAnime.imageURL)
    XCTAssertEqual(animeModel.animeTitle, codableAnime.title)
    XCTAssertEqual(animeModel.favorite, codableAnime.favorite)
  }
}
