//
//  Session.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation

protocol Session {
  func getData(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}
