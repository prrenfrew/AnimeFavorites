//
//  ImageCacheTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
import UIKit
@testable import AnimeFavorites

final class ImageCacheTests: XCTestCase {
  func testNothingAddedForKeyGivesNilValue() {
    XCTAssertNil(ImageCache.shared.getImage(from: "key"))
  }
  
  func testNewImageAddedAndGottenGivesNonNilValue() throws {
    let starImage = try XCTUnwrap(UIImage(systemName: "star.fill"))
    let starImageData = try XCTUnwrap(starImage.pngData())
    ImageCache.shared.saveImage(starImageData, with: "star.fill")
    XCTAssertNotNil(ImageCache.shared.getImage(from: "star.fill"))
  }
}
