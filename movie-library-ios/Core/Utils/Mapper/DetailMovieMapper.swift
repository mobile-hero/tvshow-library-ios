//
//  DetailMovieMapper.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation

final class DetailMovieMapper {
    static func mapMovieResponseToDomain(input origin: Movie) -> DetailMovieModel {
        return DetailMovieModel(
            id: origin.id,
            showId: origin.show?.id ?? -1,
            name: origin.name,
            image: origin.image?.medium ?? origin.image?.original ?? "-",
            summary: origin.summary ?? "No summary available",
            season: origin.season,
            number: origin.number ?? 0
        )
    }
    
    static func mapMovieDomainToEntity(input origin: DetailMovieModel) -> FavoriteMovieEntity {
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
