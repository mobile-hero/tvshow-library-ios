//
//  HomeRouter.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for movie: MovieModel) -> some View {
        let detailUseCase = Injection().provideDetail()
        let presenter = DetailPresenter(movie: movie, detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
