//
//  MainTabView.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 23/10/22.
//

import SwiftUI

struct MainTabView: View {
    let injection = Injection()
    
    var body: some View {
        TabView {
            HomeView(presenter: HomePresenter(homeUseCase: injection.provideHome()))
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoriteView(presenter: FavoritePresenter(getFavoritesUseCase: injection.provideGetFavorites()))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorite")
                }
            AboutView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("About")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
