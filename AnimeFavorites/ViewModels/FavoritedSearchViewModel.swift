//
//  FavoritedSearchViewModel.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

final class FavoritedSearchViewModel: SearchAndShowViewModel {
  
  private var animeArray: [Anime] = []
  private var searcher: Searcher!
  private let retriever: Retriever
  private let updater: Updater
  
  init(retriever: Retriever = CoreDataRetriever(),
       updater: Updater = CoreDataUpdater()) {
    self.retriever = retriever
    self.updater = updater
  }
  
  func shouldObscureWhileSearching() -> Bool {
    return false
  }
  
  func searchPlaceholder() -> String {
    return "Search Favorites"
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
      self?.searcher = FilterSearcher(array: anime)
      completion()
    }
  }
  
  func toggleFavorite(at index: Int, completion: @escaping () -> Void) {
    var animeToUpdate = self.animeArray[index]
    animeToUpdate.isFavorited = !animeToUpdate.isFavorited
    self.updater.updateModel(anime: animeToUpdate)
    self.animeArray.remove(at: index)
    completion()
  }
}
