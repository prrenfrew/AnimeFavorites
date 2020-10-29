//
//  Retriever.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

protocol Retriever {
  func retrieve(completion: @escaping ([Anime]) -> Void)
}
