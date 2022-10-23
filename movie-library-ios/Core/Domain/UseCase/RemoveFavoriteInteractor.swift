//
//  DeleteFavoriteInteractor.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 22/10/22.
//

import Foundation
import Combine

protocol RemoveFavoriteUseCase {
    func action(id: Int) -> AnyPublisher<Bool, Error>
}

class RemoveFavoriteInteractor: RemoveFavoriteUseCase {
    private let repository: TvShowRepositoryProtocol
    
    required init(repository: TvShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func action(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.removeFavorite(id: id)
    }
}
