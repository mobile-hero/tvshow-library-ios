//
//  GetFavoriteStatusInteractor.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import Foundation
import Combine

protocol GetFavoriteStatusUseCase {
    func action(id: Int) -> AnyPublisher<Bool, Error>
}

class GetFavoriteStatusInteractor: GetFavoriteStatusUseCase {
    let repository: TvShowRepositoryProtocol
    
    init(repository: TvShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func action(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.isFavorite(id: id)
    }
}
