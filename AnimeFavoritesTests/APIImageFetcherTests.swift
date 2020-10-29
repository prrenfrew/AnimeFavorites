//
//  APIImageFetcherTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class APIImageFetcherTests: XCTestCase {

    func testGettingImageFromURLGivesData() throws {
      let starImage = try XCTUnwrap(UIImage(systemName: "star"))
      let starImageData = starImage.pngData()
      let mockSession = MockSession(data: starImageData)
      let fetcher = APIImageFetcher(session: mockSession)
      fetcher.getImage(with: "urlString") { (data) in
        XCTAssertNotNil(data)
        XCTAssertEqual(data, starImageData)
      }
    }
}
