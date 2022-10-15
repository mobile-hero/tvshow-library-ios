//
//  RemoteDataSource.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getMovies() -> AnyPublisher<Movies, Error>
}

final class RemoteDataSource: NSObject {
    private let session: Session
    
    private init(session: Session) {
        self.session = session
    }
    
    static let sharedInstance: (Session) -> RemoteDataSource = { session in
        return RemoteDataSource(session: session)
    }
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getMovies() -> AnyPublisher<Movies, Error> {
        return Future<Movies, Error> { completion in
            guard let url = URL(string: Endpoints.Get.movies.url) else {
                return
            }
            
            self.session.request(url)
                .validate()
                .responseDecodable(of: Movies.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case let .failure(error):
                        print(error.localizedDescription)
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func getDetail(id: Int, season: Int, number: Int) -> AnyPublisher<Movie, Error> {
        return Future<Movie, Error> { completion in
            guard let url = URL(string: Endpoints.Get.episodeByNumber(id).url) else {
                return
            }
            
            self.session.request(url, parameters: ["season": season, "number": number])
                .validate()
                .responseDecodable(of: Movie.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case let .failure(error):
                        print(error.localizedDescription)
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
}
