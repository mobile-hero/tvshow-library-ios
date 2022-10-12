//
//  MovieMapper.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation

final class MovieMapper {
    static func mapMovieResponsesToDomains(input list: Movies) -> MovieModels {
        return list.map { origin in
            return MovieModel(
                id: origin.id,
                name: origin.name,
                image: origin.image?.medium ?? "-",
                summary: origin.summary ?? "No summary available")
        }
    }
    
    static func mapFavoriteEntityToDomains(input list: FavoriteMovieEntities) -> MovieModels {
        return list.map { origin in
            return MovieModel(
                id: origin.id,
                name: origin.name,
                image: origin.image,
                summary: origin.summary.isEmpty ? origin.summary : "No summary available")
        }
    }
    
    static func mapMovieResponseToEntity(input origin: Movie) -> FavoriteMovieEntity {
        let result = FavoriteMovieEntity()
        result.id = origin.id
        result.name = origin.name
        result.image = origin.image?.medium ?? ""
        result.summary = origin.summary ?? ""
        return result
    }
    
    static func mapMovieDomainToEntity(input origin: MovieModel) -> FavoriteMovieEntity {
        let result = FavoriteMovieEntity()
        result.id = origin.id
        result.name = origin.name
        result.image = origin.image
        result.summary = origin.summary
        return result
    }
}
