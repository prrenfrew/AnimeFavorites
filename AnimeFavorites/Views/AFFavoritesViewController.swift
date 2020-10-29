//
//  AFFavoritesViewController.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit

final class AFFavoritesViewController: AFSearchAndShowViewController {
  override func viewDidLoad() {
    self.viewModel = FavoritedSearchViewModel()
    super.viewDidLoad()
  }
}
