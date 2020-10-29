//
//  CachedImageFetcherTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class CachedImageFetcherTests: XCTestCase {
  func testImageRetrievedIsSavedToCache() {
    let imageData = self.getImageData()
    let mockSession = MockSession(data: imageData)
    let fetcher = CachedAPIImageFetcher(session: mockSession)
    fetcher.getImage(with: "example") { (_) in
      XCTAssertEqual(ImageCache.shared.getImage(from: "example"), imageData)
    }
  }
  
  func testImageRepeatedlyRequestedGottenFromCache() {
    let imageData = self.getImageData()
    var mockSession = MockSession(data: imageData, error: nil)
    var fetcher = CachedAPIImageFetcher(session: mockSession)
    fetcher.getImage(with: "secondExample") { (data) in
      XCTAssertNotNil(data)
      mockSession = MockSession(error: NetworkError.badData)
      fetcher = CachedAPIImageFetcher(session: mockSession)
      fetcher.getImage(with: "secondExample") { (data) in
        XCTAssertNotNil(data)
        XCTAssertEqual(ImageCache.shared.getImage(from: "secondExample"), data)
      }
    }
  }
  
  private func getImageData() -> Data? {
    return UIImage(systemName: "pencil")?.pngData()
  }
}
