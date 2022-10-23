//
//  FavoriteInteractor.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 22/10/22.
//

import Foundation
import Combine

protocol GetFavoritesUseCase {
    func action() -> AnyPublisher<TvShowModels, Error>
}

class GetFavoritesInteractor: GetFavoritesUseCase {
    private let repository: TvShowRepositoryProtocol
    
    required init(repository: TvShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func action() -> AnyPublisher<TvShowModels, Error> {
        return repository.getFavoriteTvShows()
    }
}
