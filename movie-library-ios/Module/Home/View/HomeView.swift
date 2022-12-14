//
//  HomeView.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import UIKit

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
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
                } else {
                    Text(presenter.errorMessage)
                }
            }.onAppear {
                if self.presenter.tvShows.count == 0 {
                    self.presenter.getTvShows()
                }
            }.navigationBarTitle(
                Text("TV Shows"),
                displayMode: .automatic
            )
        }
    }
}


