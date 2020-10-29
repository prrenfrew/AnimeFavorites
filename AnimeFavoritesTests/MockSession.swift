//
//  MockSession.swift
//  AnimeFavoritesTests
//
//  Created by MAC on 10/29/20.
//

import Foundation
@testable import AnimeFavorites

class MockSession: Session {
  
  private let error: Error?
  private let data: Data?
  
  init(data: Data? = nil, error: Error? = nil) {
    self.data = data
    self.error = error
  }
  
  
  func getData(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
    completion(self.data, self.error)
  }
}
