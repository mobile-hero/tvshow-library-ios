//
//  Injection.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift
import Alamofire

class Injection: NSObject {
    func provideRepository() -> TvShowRepository {
        let locale = LocaleDataSource.sharedInstance(realm)
        let remote = RemoteDataSource.sharedInstance(sessionManager)
        return TvShowRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideGetFavorites() -> GetFavoritesUseCase {
        let repository = provideRepository()
        return GetFavoritesInteractor(repository: repository)
    }
    
    func provideGetFavoriteStatus() -> GetFavoriteStatusUseCase {
        let repository = provideRepository()
        return GetFavoriteStatusInteractor(repository: repository)
    }
    
    func provideAddFavorite() -> AddFavoriteUseCase {
        let repository = provideRepository()
        return AddFavoriteInteractor(repository: repository)
    }
    
    func provideRemoveFavorite() -> RemoveFavoriteUseCase {
        let repository = provideRepository()
        return RemoveFavoriteInteractor(repository: repository)
    }
    
    lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10
        
        let networkLogger = NetworkLogger()
        
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
}
