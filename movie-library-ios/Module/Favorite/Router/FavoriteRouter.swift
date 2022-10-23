//
//  FavoriteRouter.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import SwiftUI

class FavoriteRouter {
    func makeDetailView(for tvShow: TvShowModel) -> some View {
        let injection = Injection()
        let detailUseCase = injection.provideDetail()
        let presenter = DetailPresenter(tvShow: tvShow,
                                        detailUseCase: detailUseCase,
                                        addFavoriteUseCase: injection.provideAddFavorite(),
                                        removeFavoriteUseCase: injection.provideRemoveFavorite(),
                                        getFavoriteStatusUseCase: injection.provideGetFavoriteStatus())
        return DetailView(presenter: presenter)
    }
}
