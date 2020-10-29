//
//  AnimeSearchViewModelTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class AnimeSearchViewModelTests: XCTestCase {
  
  override func tearDownWithError() throws {
    CoreDataManager.shared.context.rollback()
  }
  
  func testInitialValues() {
    let viewModel = AnimeSearchViewModel()
    XCTAssertEqual(viewModel.numberOfObjectsToShow(), 0)
    XCTAssertEqual(viewModel.searchPlaceholder(), "Search Anime")
    XCTAssertEqual(viewModel.shouldObscureWhileSearching(), false)
  }
  
  func testRetrievingGivesNoObjectsToShow() {
    let viewModel = AnimeSearchViewModel()
    viewModel.retrieveObjects {
      XCTAssertEqual(viewModel.numberOfObjectsToShow(), 0)
    }
  }
  
  func testSearchGivesAnimes() {
    self.setupViewModel { (vm) in
      XCTAssertEqual(vm.numberOfObjectsToShow(), 3)
    }
  }
  
  func testTogglingAnimeAddsToContext() {
    self.setupViewModel { (vm) in
      vm.toggleFavorite(at: 0) {
        XCTAssertEqual(CoreDataManager.shared.context.insertedObjects.count, 1)
      }
    }
  }
  
  func testGettingDetailViewModel() {
    self.setupViewModel { (vm) in
      let detailVM = vm.detailViewModel(for: 0)
      XCTAssertEqual(detailVM.name(), "a")
    }
  }
  
  private func setupViewModel(completion: @escaping (AnimeSearchViewModel) -> Void) {
    let resultsData = try? JSONEncoder().encode(self.createAnimeResults())
    let mockSession = MockSession(data: resultsData, error: nil)
    let viewModel = AnimeSearchViewModel(searcher: APISearcher(session: mockSession))
    viewModel.search(with: "a") {
      completion(viewModel)
    }
  }
  
  private func createAnimeResults() -> AnimeResults {
    let animeArray = [CodableAnime(title: "a", imageURL: "b"), CodableAnime(title: "c", imageURL: "d"), CodableAnime(title: "e", imageURL: "f")]
    return AnimeResults(results: animeArray)
  }
}
