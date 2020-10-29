//
//  LayoutConstraint+Extensions.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit

extension NSLayoutXAxisAnchor {
  func setupHorizontalConstraint(to toConstraint: NSLayoutXAxisAnchor, offset: CGFloat = 0) {
    self.constraint(equalTo: toConstraint, constant: offset).isActive = true
  }
}

extension NSLayoutYAxisAnchor {
  func setupVerticalConstraint(to toConstraint: NSLayoutYAxisAnchor, offset: CGFloat = 0) {
    self.constraint(equalTo: toConstraint, constant: offset).isActive = true
  }
}
