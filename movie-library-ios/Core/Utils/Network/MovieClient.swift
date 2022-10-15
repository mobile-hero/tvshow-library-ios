//
//  MovieClient.swift
//  movie-library-composable
//
//  Created by Majoo Apple  on 28/08/22.
//

import Foundation
import Combine

struct MovieAPI {
    static let baseUrl = "https://api.tvmaze.com/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Get: Endpoint {
        case movies
        case episodeByNumber(Int)
        
        var url: String {
            let path: String = {
                switch self {
                case .movies: return "schedule"
                case .episodeByNumber(let id): return "shows/\(id)/episodebynumber"
                }
            }()
            
            return MovieAPI.baseUrl + path
        }
    }
}

class MovieClient {
    
    
    
//    func loadMovies() -> Effect<Movies, APIError> {
//        let url = URL(string: baseUrl + "schedule")!
//        let publisher: AnyPublisher<Movies, Error> = URLSession.shared.codableTask(with: url)
//        let values = publisher.values
//        print(values)
//        return publisher.mapError {
//            if $0 is APIError {
//                return $0 as! APIError
//            } else {
//                return APIError.unexpected($0, $0.localizedDescription)
//            }
//        }.eraseToEffect()
//        return Effect.run(priority: .userInitiated) { send in
//            let publisher: AnyPublisher<Movies, Error> = URLSession.shared.codableTask(with: url)
//            let values = publisher.values
//            print(values)
//            send(publisher.eraseToEffect())
//        } catch: { error, send in
//            await send((nil, error))
//        }

        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: Movies.self, decoder: newJSONDecoder())
//            .eraseToAnyPublisher()
//        let task = URLSession.shared.codableTask(with: url).map(Movie.init).receive(on: DispatchQueue.main).sink { response in
//            switch response {
//            case .failure(let error):
//                print("Failed with error: \(error)")
//                return
//            case .finished:
//                print("Succeesfully finished!")
//            }
//        } receiveValue: { value in
//            print(value)
//        }
//
////        task.resume()
//        return task
//    }
}
