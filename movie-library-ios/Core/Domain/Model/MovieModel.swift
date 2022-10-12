//
//  MovieModel.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let summary: String
}

typealias MovieModels = [MovieModel]
