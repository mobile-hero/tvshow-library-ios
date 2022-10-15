//
//  DetailPresenter.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = DetailRouter()
    private let detailUseCase: DetailUseCase
    
    @Published var movie: MovieModel
    @Published var detailMovie: DetailMovieModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(movie: MovieModel, detailUseCase: DetailUseCase) {
        self.movie = movie
        self.detailUseCase = detailUseCase
    }
    
    func getDetail() {
        loadingState = true
        detailUseCase.getDetail(id: movie.showId, season: movie.season, number: movie.number)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { detail in
                self.detailMovie = detail
            }
            .store(in: &cancellables)
    }
}
