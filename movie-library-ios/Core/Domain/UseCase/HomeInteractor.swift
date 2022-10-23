//
//  HomeUseCase.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getTvShows() -> AnyPublisher<TvShowModels, Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: TvShowRepositoryProtocol
    
    required init(repository: TvShowRepositoryProtocol){
        self.repository = repository
    }
    
    func getTvShows() -> AnyPublisher<TvShowModels, Error> {
        return repository.getTvShows()
    }
}
