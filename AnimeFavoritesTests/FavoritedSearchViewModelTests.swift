//
//  FavoritedSearchViewModelTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class FavoritedSearchViewModelTests: XCTestCase {

  override func tearDownWithError() throws {
    CoreDataManager.shared.context.rollback()
  }
  
  func testInitialValues() {
    let viewModel = FavoritedSearchViewModel()
    XCTAssertEqual(viewModel.numberOfObjectsToShow(), 0)
    XCTAssertEqual(viewModel.searchPlaceholder(), "Search Favorites")
    XCTAssertEqual(viewModel.shouldObscureWhileSearching(), false)
  }
  
  func testRetrievingGivesObjectsToShow() {
    let viewModel = FavoritedSearchViewModel(retriever: MockRetriever(animes: self.createAnimeResults()))
    viewModel.retrieveObjects {
      XCTAssertEqual(viewModel.numberOfObjectsToShow(), 3)
    }
  }
  
  func testSearchReducesNumberOfResults() {
    self.setupViewModel { (vm) in
      vm.search(with: "a") {
        XCTAssertEqual(vm.numberOfObjectsToShow(), 1)
      }
    }
  }
  
  func testGettingDetailViewModel() {
    self.setupViewModel { (vm) in
      let detailVM = vm.detailViewModel(for: 0)
      XCTAssertEqual(detailVM.name(), "a")
    }
  }
  
  func testTogglingAnimeFavoriteRemoves() {
    self.setupViewModel { (vm) in
      vm.toggleFavorite(at: 0) {
        XCTAssertEqual(vm.numberOfObjectsToShow(), 2)
      }
    }
  }
  
  private func setupViewModel(completion: @escaping (FavoritedSearchViewModel) -> Void) {
    let viewModel = FavoritedSearchViewModel(retriever: MockRetriever(animes: self.createAnimeResults()))
    viewModel.retrieveObjects {
      completion(viewModel)
    }
  }
  
  private func createAnimeResults() -> [Anime] {
    let animeArray = [CodableAnime(favorite: true, title: "a", imageURL: "b"), CodableAnime(favorite: true, title: "c", imageURL: "d"), CodableAnime(favorite: true, title: "e", imageURL: "f")]
    let managedAnimes = animeArray.map { CodableAnimeToAnimeModelAdapter(anime: $0) }.compactMap { $0.convert() }
    managedAnimes.forEach { CoreDataManager.shared.insertObject($0) }
    return managedAnimes
  }

}

class MockRetriever: Retriever {
  
  private let animes: [Anime]
  
  init(animes: [Anime]) {
    self.animes = animes
  }
  
  func retrieve(completion: @escaping ([Anime]) -> Void) {
    completion(self.animes)
  }
}
