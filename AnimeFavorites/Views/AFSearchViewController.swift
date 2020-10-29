//
//  AFSearchViewController.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit

final class AFSearchViewController: AFSearchAndShowViewController {
  
  override func viewDidLoad() {
    self.viewModel = AnimeSearchViewModel()
    super.viewDidLoad()
  }
}

