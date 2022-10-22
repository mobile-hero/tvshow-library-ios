//
//  MovieModel.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
    let id: Int
    let showId: Int
    let showName: String
    let name: String
    let image: String
    let imageOriginal: String
    let summary: String
    let season: Int
    let number: Int
}

typealias MovieModels = [MovieModel]
