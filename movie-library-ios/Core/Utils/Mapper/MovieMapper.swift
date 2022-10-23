//
//  TvShowMapper.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation

final class TvShowMapper {
    static func mapTvShowResponsesToDomains(input list: TvShows) -> TvShowModels {
        return list.map { origin in
            return TvShowModel(
                id: origin.id,
                showId: origin.show!.id,
                showName: origin.show!.name,
                name: origin.name,
                image: origin.image?.medium ?? origin.show?.image?.medium ?? "-",
                imageOriginal: origin.image?.original ?? origin.show?.image?.original ?? "-",
                summary: origin.summary ?? "No summary available",
                season: origin.season ?? 0,
                number: origin.number ?? 0
            )
        }
    }
    
    static func mapTvShowResponseToDomain(input origin: TvShow) -> TvShowModel {
        return TvShowModel(
            id: origin.id,
            showId: origin.show!.id,
            showName: origin.show!.name,
            name: origin.name,
            image: origin.image?.medium ?? origin.show?.image?.medium ?? "-",
            imageOriginal: origin.image?.original ?? origin.show?.image?.original ?? "-",
            summary: origin.summary ?? "No summary available",
            season: origin.season ?? 0,
            number: origin.number ?? 0
        )
    }
    
    static func mapFavoriteEntityToDomains(input list: FavoriteTvShowEntities) -> TvShowModels {
        return list.map { origin in
            return TvShowModel(
                id: origin.id,
                showId: origin.showId,
                showName: origin.showName,
                name: origin.name,
                image: origin.image,
                imageOriginal: origin.imageOriginal,
                summary: origin.summary.isEmpty ? origin.summary : "No summary available",
                season: origin.season,
                number: origin.number
            )
        }
    }
    
    static func mapTvShowResponseToEntity(input origin: TvShow) -> FavoriteTvShowEntity {
        let result = FavoriteTvShowEntity()
        result.id = origin.id
        result.showId = origin.show!.id
        result.showName = origin.show!.name
        result.name = origin.name
        result.image = origin.image?.medium ?? ""
        result.imageOriginal = origin.image?.original ?? ""
        result.summary = origin.summary ?? ""
        result.season = origin.season ?? 0
        result.number = origin.number ?? 0
        return result
    }
    
    static func mapTvShowDomainToEntity(input origin: TvShowModel) -> FavoriteTvShowEntity {
        let result = FavoriteTvShowEntity()
        result.id = origin.id
        result.showId = origin.showId
        result.showName = origin.showName
        result.name = origin.name
        result.image = origin.image
        result.imageOriginal = origin.imageOriginal
        result.summary = origin.summary
        result.season = origin.season
        result.number = origin.number
        return result
    }
}
