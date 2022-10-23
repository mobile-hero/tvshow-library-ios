//
//  AddFavoriteInteractor.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 22/10/22.
//

import Foundation
import Combine

protocol AddFavoriteUseCase {
    func action(show: TvShowModel) -> AnyPublisher<Bool, Error>
}

class AddFavoriteInteractor: AddFavoriteUseCase {
    private let repository: TvShowRepositoryProtocol
    
    required init(repository: TvShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func action(show: TvShowModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(tvShow: show)
    }
}
