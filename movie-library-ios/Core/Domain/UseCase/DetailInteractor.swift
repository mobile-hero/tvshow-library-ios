//
//  DetailInteractor.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailTvShowModel, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: TvShowRepositoryProtocol
    
    required init(repository: TvShowRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<DetailTvShowModel, Error> {
        return repository.getDetail(id: id, season: season, number: number)
    }
}
