//
//  APIRetriever.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

final class APIRetriever: Retriever {
  func retrieve(completion: @escaping ([Anime]) -> Void) {
    //This is for initial retrieval, which will be none for the API, since it will only have a non-empty array after the user searches
    completion([])
  }
}
