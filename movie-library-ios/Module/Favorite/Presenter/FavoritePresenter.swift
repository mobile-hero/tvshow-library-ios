//
//  FavoritePresenter.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 22/10/22.
//

import Foundation
import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private var router = FavoriteRouter()
    private let getFavoritesUseCase: GetFavoritesUseCase
    
    @Published var tvShows: TvShowModels = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(getFavoritesUseCase: GetFavoritesUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
    
    func getTvShows() {
        loadingState = true
        getFavoritesUseCase.action()
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
