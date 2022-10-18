//
//  HomeView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        VStack {
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
                        self.presenter.linkBuilder(for: movie) {
                            VStack {
                                WebImage(url: URL(string: movie.image))
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                    }
                                    .indicator(.activity)
                                    .frame(width: .infinity, height: 150, alignment: .center)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Rectangle(), style: FillStyle(eoFill: true, antialiased: true))
                                    .clipped()
                                Text(movie.showName)
                                    .font(Font.system(size: 14))
                                    .foregroundColor(Color(UIColor.darkGray))
                                    .multilineTextAlignment(.center)
                                Text(movie.name)
                                    .multilineTextAlignment(.center)
                            }.padding(8)
                        }.buttonStyle(PlainButtonStyle())
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
