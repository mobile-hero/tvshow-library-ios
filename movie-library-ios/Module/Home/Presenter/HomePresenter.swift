//
//  HomePresenter.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private var router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var movies: MovieModels = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getMovies() {
        loadingState = true
        homeUseCase.getMovies()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { movies in
                self.movies = movies
            }
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for movie: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: EmptyView()) { content() }
    }
}
