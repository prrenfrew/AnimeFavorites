//
//  SearcherTests.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import XCTest
@testable import AnimeFavorites

final class SearcherTests: XCTestCase {
  
  func testAPISearcherGivesCorrectNumberOfAnimes() {
    let results = self.createAnimeResults()
    let resultsData = try? JSONEncoder().encode(results)
    let mockSession = MockSession(data: resultsData)
    let apiSearcher = APISearcher(session: mockSession)
    apiSearcher.search(with: "term") { animeArray in
      XCTAssertEqual(animeArray.count, 3)
    }
  }
  
  func testFilterSearcherGivesCorrectNumberOFAnimes() {
    let animes = self.createAnimeResults().results
    let searcher = FilterSearcher(array: animes)
    searcher.search(with: "a") { (animeArray) in
      XCTAssertEqual(animeArray.count, 1)
    }
    searcher.search(with: "ab") { (animeArray) in
      XCTAssertTrue(animeArray.isEmpty)
    }
    
    searcher.search(with: "") { (animeArray) in
      XCTAssertEqual(animeArray.count, 3)
    }
  }
  
  func testAPISearcherReturnsEmptyArrayWheError() {
    var mockSession = MockSession()
    var searcher = APISearcher(session: mockSession)
    searcher.search(with: "a") { (animes) in
      XCTAssertTrue(animes.isEmpty)
    }
    
    mockSession = MockSession(data: Data())
    searcher = APISearcher(session: mockSession)
    searcher.search(with: "a") { (animes) in
      XCTAssertTrue(animes.isEmpty)
    }
    
    mockSession = MockSession(error: NetworkError.badData)
    searcher = APISearcher(session: mockSession)
    searcher.search(with: "a") { (animes) in
      XCTAssertTrue(animes.isEmpty)
    }
  }
  
  private func createAnimeResults() -> AnimeResults {
    let animeArray = [CodableAnime(title: "a", imageURL: "b"), CodableAnime(title: "c", imageURL: "d"), CodableAnime(title: "e", imageURL: "f")]
    return AnimeResults(results: animeArray)
  }

}
