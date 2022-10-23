//
//  TvShowClient.swift
//  tvShow-library-composable
//
//  Created by Majoo Apple  on 28/08/22.
//

import Foundation
import Combine

struct TvShowAPI {
    static let baseUrl = "https://api.tvmaze.com/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Get: Endpoint {
        case tvShows
        case episodeByNumber(Int)
        
        var url: String {
            let path: String = {
                switch self {
                case .tvShows: return "schedule"
                case .episodeByNumber(let id): return "shows/\(id)/episodebynumber"
                }
            }()
            
            return TvShowAPI.baseUrl + path
        }
    }
}

class TvShowClient {
    
    
    
//    func loadTvShows() -> Effect<TvShows, APIError> {
//        let url = URL(string: baseUrl + "schedule")!
//        let publisher: AnyPublisher<TvShows, Error> = URLSession.shared.codableTask(with: url)
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
//            let publisher: AnyPublisher<TvShows, Error> = URLSession.shared.codableTask(with: url)
//            let values = publisher.values
//            print(values)
//            send(publisher.eraseToEffect())
//        } catch: { error, send in
//            await send((nil, error))
//        }

        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: TvShows.self, decoder: newJSONDecoder())
//            .eraseToAnyPublisher()
//        let task = URLSession.shared.codableTask(with: url).map(TvShow.init).receive(on: DispatchQueue.main).sink { response in
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
