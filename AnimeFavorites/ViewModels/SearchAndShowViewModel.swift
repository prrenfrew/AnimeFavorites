//
//  SearchAndShowViewModel.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

protocol SearchAndShowViewModel {
  func shouldObscureWhileSearching() -> Bool
  func searchPlaceholder() -> String
  func search(with text: String, completion: @escaping () -> Void)
  func numberOfObjectsToShow() -> Int
  func detailViewModel(for index: Int) -> DetailViewModel
  func retrieveObjects(completion: @escaping () -> Void)
  func toggleFavorite(at index: Int, completion: @escaping () -> Void)
}
