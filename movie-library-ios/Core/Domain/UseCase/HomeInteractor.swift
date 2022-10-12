//
//  HomeUseCase.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getMovies() -> AnyPublisher<MovieModels, Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getMovies() -> AnyPublisher<MovieModels, Error> {
        return repository.getMovies()
    }
}
