//
//  MovieRepository.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getMovies() -> AnyPublisher<MovieModels, Error>
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailMovieModel, Error>
    func getFavoriteMovies() -> AnyPublisher<MovieModels, Error>
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

final class MovieRepository: NSObject {
    typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { locale, remote in
        return MovieRepository(locale: locale, remote: remote)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getMovies() -> AnyPublisher<MovieModels, Error> {
        return remote.getMovies().map {
            MovieMapper.mapMovieResponsesToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return remote.getDetail(id: id, season: season, number: number).map {
            DetailMovieMapper.mapMovieResponseToDomain(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteMovies() -> AnyPublisher<MovieModels, Error> {
        return locale.getFavorites().map {
            MovieMapper.mapFavoriteEntityToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return locale.add(movie: MovieMapper.mapMovieDomainToEntity(input: movie))
            .eraseToAnyPublisher()
    }
    
    func removeFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return locale.remove(movie: MovieMapper.mapMovieDomainToEntity(input: movie))
            .eraseToAnyPublisher()
    }
    
    
}
