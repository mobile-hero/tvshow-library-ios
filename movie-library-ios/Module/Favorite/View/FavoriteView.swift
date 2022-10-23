//
//  FavoriteView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    
    let columns = [GridItem(alignment: Alignment(horizontal: .leading, vertical: .top)),
                   GridItem(alignment: Alignment(horizontal: .leading, vertical: .top))]
    
    var body: some View {
        NavigationView {
            VStack {
                if presenter.loadingState {
                    VStack {
                        Text("Loading...")
                        ActivityIndicator()
                    }
                } else if !presenter.tvShows.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: self.columns, spacing: 5) {
                            ForEach(
                                self.presenter.tvShows,
                                id: \.id
                            ) { tvShow in
                                self.presenter.linkBuilder(for: tvShow) {
                                    ShowCell(show: tvShow)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                } else if presenter.tvShows.isEmpty {
                    CustomEmptyView(image: "film.fill", title: "Anda belum menambahkan show favorit")
                } else {
                    Text(presenter.errorMessage)
                }
            }.onAppear {
                self.presenter.getTvShows()
            }.navigationBarTitle(
                Text("Favorites"),
                displayMode: .automatic
            )
        }
    }
}
