//
//  movie_library_iosApp.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import SwiftUI
import Alamofire

@main
struct movie_library_iosApp: App {
    let persistenceController = PersistenceController.shared
    
    let injection = Injection()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            NavigationView {
                HomeView(presenter: HomePresenter(homeUseCase: injection.provideHome()))
            }
        }
    }
}
