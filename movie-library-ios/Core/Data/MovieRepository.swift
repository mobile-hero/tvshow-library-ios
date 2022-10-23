//
//  TvShowRepository.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import Combine

protocol TvShowRepositoryProtocol {
    func getTvShows() -> AnyPublisher<TvShowModels, Error>
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailTvShowModel, Error>
    func getFavoriteTvShows() -> AnyPublisher<TvShowModels, Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func addFavorite(tvShow: TvShowModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class TvShowRepository: NSObject {
    typealias TvShowInstance = (LocaleDataSource, RemoteDataSource) -> TvShowRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: TvShowInstance = { locale, remote in
        return TvShowRepository(locale: locale, remote: remote)
    }
}

extension TvShowRepository: TvShowRepositoryProtocol {
    func getTvShows() -> AnyPublisher<TvShowModels, Error> {
        return remote.getTvShows().map {
            TvShowMapper.mapTvShowResponsesToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailTvShowModel, Error> {
        return remote.getDetail(id: id, season: season, number: number).map {
            DetailTvShowMapper.mapTvShowResponseToDomain(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteTvShows() -> AnyPublisher<TvShowModels, Error> {
        return locale.getFavorites().map {
            TvShowMapper.mapFavoriteEntityToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return locale.isFavorite(id: id)
    }
    
    func addFavorite(tvShow: TvShowModel) -> AnyPublisher<Bool, Error> {
        return locale.add(tvShow: TvShowMapper.mapTvShowDomainToEntity(input: tvShow))
            .eraseToAnyPublisher()
    }
    
    func removeFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return locale.remove(id: id)
    }
}
