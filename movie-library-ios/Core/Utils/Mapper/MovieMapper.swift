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
                showId: origin.show!.id,
                name: origin.name,
                image: origin.image?.medium ?? origin.image?.original ?? "-",
                summary: origin.summary ?? "No summary available",
                season: origin.season,
                number: origin.number ?? 0
            )
        }
    }
    
    static func mapMovieResponseToDomain(input origin: Movie) -> MovieModel {
        return MovieModel(
            id: origin.id,
            showId: origin.show!.id,
            name: origin.name,
            image: origin.image?.medium ?? origin.image?.original ?? "-",
            summary: origin.summary ?? "No summary available",
            season: origin.season,
            number: origin.number ?? 0
        )
    }
    
    static func mapFavoriteEntityToDomains(input list: FavoriteMovieEntities) -> MovieModels {
        return list.map { origin in
            return MovieModel(
                id: origin.id,
                showId: origin.showId,
                name: origin.name,
                image: origin.image,
                summary: origin.summary.isEmpty ? origin.summary : "No summary available",
                season: origin.season,
                number: origin.number
            )
        }
    }
    
    static func mapMovieResponseToEntity(input origin: Movie) -> FavoriteMovieEntity {
        let result = FavoriteMovieEntity()
        result.id = origin.id
        result.showId = origin.show!.id
        result.name = origin.name
        result.image = origin.image?.medium ?? ""
        result.summary = origin.summary ?? ""
        result.season = origin.season
        result.number = origin.number ?? 0
        return result
    }
    
    static func mapMovieDomainToEntity(input origin: MovieModel) -> FavoriteMovieEntity {
        let result = FavoriteMovieEntity()
        result.id = origin.id
        result.showId = origin.showId
        result.name = origin.name
        result.image = origin.image
        result.summary = origin.summary
        result.season = origin.season
        result.number = origin.number
        return result
    }
}
