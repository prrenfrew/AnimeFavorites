//
//  AnimeTableViewCell.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit

final class AnimeTableViewCell: UITableViewCell {
  @IBOutlet weak var animeImageView: UIImageView!
  @IBOutlet weak var favoritedStarImageView: UIImageView!
  @IBOutlet weak var animeNameLabel: UILabel!
  
  private var viewModel: DetailViewModel? {
    didSet {
      self.updateView()
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.viewModel = nil
    self.animeNameLabel.text = ""
    self.animeImageView.image = nil
  }
  
  func configure(with viewModel: DetailViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateView() {
    self.animeNameLabel.text = self.viewModel?.name()
    updateFavorite()
    self.viewModel?.getImageData(completion: { [weak self] (data) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self?.animeImageView.image = UIImage(data: data)
      }
    })
  }
  
  private func updateFavorite() {
    self.favoritedStarImageView.image = self.viewModel?.isFavorited() == true
      ? UIImage(systemName: "star.fill")
      : UIImage(systemName: "star")
  }
}
