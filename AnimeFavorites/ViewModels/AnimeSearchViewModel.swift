//
//  AnimeSearchViewModel.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

final class AnimeSearchViewModel: SearchAndShowViewModel {
  
  private var animeArray: [Anime] = []
  private let searcher: Searcher
  private let retriever: Retriever
  private let updater: Updater
  
  init(searcher: Searcher = APISearcher(),
       retriever: Retriever = APIRetriever(),
       updater: Updater = CoreDataUpdater()) {
    self.searcher = searcher
    self.retriever = retriever
    self.updater = updater
  }
  
  func shouldObscureWhileSearching() -> Bool {
    return false
  }
  
  func searchPlaceholder() -> String {
    return "Search Anime"
  }
  
  func search(with text: String, completion: @escaping () -> Void) {
    self.searcher.search(with: text) { [weak self] anime in
      self?.animeArray = anime
      completion()
    }
  }
  
  func numberOfObjectsToShow() -> Int {
    return self.animeArray.count
  }
  
  func detailViewModel(for index: Int) -> DetailViewModel {
    return AnimeDetailViewModel(anime: self.animeArray[index])
  }
  
  func retrieveObjects(completion: @escaping () -> Void) {
    self.retriever.retrieve { [weak self] anime in
      self?.animeArray = anime
      completion()
    }
  }
  
  func toggleFavorite(at index: Int, completion: @escaping () -> Void) {
    var animeToUpdate = self.animeArray[index]
    animeToUpdate.isFavorited = !animeToUpdate.isFavorited
    self.updater.updateModel(anime: animeToUpdate)
    completion()
  }
}
