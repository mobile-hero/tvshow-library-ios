//
//  DetailPresenter.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = DetailRouter()
    private let detailUseCase: DetailUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUseCase
    private let getFavoriteStatusUseCase: GetFavoriteStatusUseCase
    
    @Published var tvShow: TvShowModel
    @Published var detailTvShow: DetailTvShowModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorite: Bool = false
    
    init(tvShow: TvShowModel,
         detailUseCase: DetailUseCase,
         addFavoriteUseCase: AddFavoriteUseCase,
         removeFavoriteUseCase: RemoveFavoriteUseCase,
         getFavoriteStatusUseCase: GetFavoriteStatusUseCase
    ) {
        self.tvShow = tvShow
        self.detailUseCase = detailUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.getFavoriteStatusUseCase = getFavoriteStatusUseCase
    }
    
    func getDetail() {
        print("loading detail")
        loadingState = true
        detailUseCase.getDetail(id: tvShow.showId, season: tvShow.season, number: tvShow.number)
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
                self.detailTvShow = detail
                self.detailTvShow?.showName = self.tvShow.showName
                self.detailTvShow?.image = self.tvShow.image
                self.detailTvShow?.imageOriginal = self.tvShow.imageOriginal
                
                self.checkFavorite()
            }
            .store(in: &cancellables)
    }
    
    func checkFavorite() {
        getFavoriteStatusUseCase.action(id: tvShow.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("getFavoriteStatus success")
                }
            } receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            }
            .store(in: &cancellables)
    }
    
    func addFavorite() {
        self.isFavorite = true
        addFavoriteUseCase.action(show: tvShow)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { success in
                print("addFavorite \(success)")
                self.isFavorite = true
            }
            .store(in: &cancellables)
    }
    
    func removeFavorite() {
        removeFavoriteUseCase.action(id: tvShow.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { success in
                print("removeFavorite \(success)")
                self.isFavorite = false
            }
            .store(in: &cancellables)
    }
}
