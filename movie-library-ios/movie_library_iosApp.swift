//
//  tvShow_library_iosApp.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import SwiftUI
import Alamofire

@main
struct tvShow_library_iosApp: App {
    
    let injection = Injection()

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
