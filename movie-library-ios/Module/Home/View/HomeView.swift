//
//  HomeView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            } else if !presenter.movies.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.movies,
                        id: \.id
                    ) { movie in
                        ZStack {
                            self.presenter.linkBuilder(for: movie) {
                                Image(movie.image)
                                Text(movie.name)
                            }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                    }
                }
            } else {
                Text(presenter.errorMessage)
            }
        }.onAppear {
            if self.presenter.movies.count == 0 {
                self.presenter.getMovies()
            }
        }.navigationBarTitle(
            Text("Movies"),
            displayMode: .automatic
        )
    }
}
