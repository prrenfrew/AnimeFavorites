//
//  APISearcher.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

struct AnimeResults: Codable {
  let results: [CodableAnime]
}

final class APISearcher: Searcher {
  
  private let session: Session
  
  init(session: Session = URLSession.shared) {
    self.session = session
  }
  
  func search(with term: String, completion: @escaping ([Anime]) -> Void) {
    let searchURLString = "https://api.jikan.moe/v3/search/anime?q=\(term)&page=1"
    self.session.getData(urlString: searchURLString) { (data, error) in
      guard let data = data, error == nil else {
        completion([])
        return
      }
      do {
        let results = try JSONDecoder().decode(AnimeResults.self, from: data)
        let codableAnimes = results.results
        let animeModels = codableAnimes
          .map { CodableAnimeToAnimeModelAdapter(anime: $0) }
          .compactMap { $0.convert() }
        completion(animeModels)
      } catch {
        completion([])
      }
    }
  }
}
