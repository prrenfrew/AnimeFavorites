//
//  APIRetrieverTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class APIRetrieverTests: XCTestCase {
  func testAPIRetrieverGivesEmptyArray() {
    APIRetriever().retrieve { (animes) in
      XCTAssertTrue(animes.isEmpty)
    }
  }
}
