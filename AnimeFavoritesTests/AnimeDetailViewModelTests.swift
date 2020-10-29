//
//  AnimeDetailViewModelTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class AnimeDetailViewModelTests: XCTestCase {
  
  func testIsFavoriteGetsCorrectValue() {
    var anime = self.createAnime()
    var viewModel = AnimeDetailViewModel(anime: anime)
    XCTAssertFalse(viewModel.isFavorited())
    anime.isFavorited = true
    viewModel = AnimeDetailViewModel(anime: anime)
    XCTAssertTrue(viewModel.isFavorited())
  }
  
  func testFetchesImage() {
    let imageData = UIImage(systemName: "star")?.pngData()
    let viewModel = AnimeDetailViewModel(anime: self.createAnime(), imageFetcher: MockImageFetcher(imageData: imageData))
    viewModel.getImageData { (data) in
      XCTAssertEqual(imageData, data)
    }
  }

  private func createAnime() -> Anime {
    return CodableAnime(favorite: false, title: "title", imageURL: "imageURL")
  }
  
}

class MockImageFetcher: ImageFetcher {
  
  private let imageData: Data?
  
  init(imageData: Data?) {
    self.imageData = imageData
  }
  
  func getImage(with urlString: String, completion: @escaping (Data?) -> Void) {
    completion(self.imageData)
  }
}
