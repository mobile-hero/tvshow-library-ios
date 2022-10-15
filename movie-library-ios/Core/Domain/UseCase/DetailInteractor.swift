//
//  DetailInteractor.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailMovieModel, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return repository.getDetail(id: id, season: season, number: number)
    }
}
