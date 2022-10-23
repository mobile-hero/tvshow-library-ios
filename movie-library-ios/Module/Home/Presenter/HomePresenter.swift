//
//  HomePresenter.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private var router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var tvShows: TvShowModels = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getTvShows() {
        loadingState = true
        homeUseCase.getTvShows()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { tvShows in
                self.tvShows = tvShows
            }
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for tvShow: TvShowModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: tvShow)) { content() }
    }
}
