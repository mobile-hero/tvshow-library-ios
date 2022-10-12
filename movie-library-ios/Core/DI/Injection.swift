//
//  Injection.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift
import Alamofire

class Injection: NSObject {
    func provideRepository() -> MovieRepository {
        let realm = try? Realm()
        let locale = LocaleDataSource.sharedInstance(realm)
        let remote = RemoteDataSource.sharedInstance(sessionManager)
        return MovieRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> Any {
        return false
    }
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10
        
        let networkLogger = NetworkLogger()
        
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
}
