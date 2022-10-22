// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? newJSONDecoder().decode(Movies.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.movieTask(with: url) { movie, response, error in
//     if let movie = movie {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Movie
struct Movie: Codable, Equatable, Identifiable {
    let id: Int
    let url: String
    let name: String
    let season: Int?
    let number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: Rating
    let image: ImageObject?
    let summary: String?
    let show: Show?
    let links: MovieLinks

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary, show
        case links = "_links"
    }
}

typealias Movies = [Movie]

//
// To read values from URLs:
//
//   let task = URLSession.shared.imageTask(with: url) { image, response, error in
//     if let image = image {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Image
struct ImageObject: Codable, Equatable {
    let medium: String
    let original: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.movieLinksTask(with: url) { movieLinks, response, error in
//     if let movieLinks = movieLinks {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - MovieLinks
struct MovieLinks: Codable, Equatable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.selfClassTask(with: url) { selfClass, response, error in
//     if let selfClass = selfClass {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - SelfClass
struct SelfClass: Codable, Equatable {
    let href: String?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.ratingTask(with: url) { rating, response, error in
//     if let rating = rating {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Rating
struct Rating: Codable, Equatable {
    let average: Double?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.showTask(with: url) { show, response, error in
//     if let show = show {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Show
struct Show: Codable, Equatable {
    let id: Int
    let url: String
    let name, type: String
    let language: String?
    let genres: [String]
    let status: Status
    let runtime, averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network, webChannel: Network?
    let dvdCountry: String?
    let externals: Externals
    let image: ImageObject?
    let summary: String?
    let updated: Int?
    let links: ShowLinks

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.externalsTask(with: url) { externals, response, error in
//     if let externals = externals {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Externals
struct Externals: Codable, Equatable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.showLinksTask(with: url) { showLinks, response, error in
//     if let showLinks = showLinks {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - ShowLinks
struct ShowLinks: Codable, Equatable {
    let linksSelf: SelfClass?
    let previousepisode: SelfClass?
    let nextepisode: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.networkTask(with: url) { network, response, error in
//     if let network = network {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Network
struct Network: Codable, Equatable {
    let id: Int
    let name: String
    let country: Country
    let officialSite: String?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.countryTask(with: url) { country, response, error in
//     if let country = country {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Country
struct Country: Codable, Equatable {
//    let name: Name
//    let code: Code
//    let timezone: Timezone
    let name: String
    let code: String
    let timezone: String
}

enum Code: String, Codable, Equatable {
    case us = "US"
}

enum Name: String, Codable, Equatable {
    case unitedStates = "United States"
}

enum Timezone: String, Codable, Equatable {
    case americaNewYork = "America/New_York"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.scheduleTask(with: url) { schedule, response, error in
//     if let schedule = schedule {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Schedule
struct Schedule: Codable, Equatable {
    let time: String
    let days: [Day]
}

enum Day: String, Codable, Equatable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

enum Status: String, Codable, Equatable {
    case running = "Running"
    case toBeDetermined = "To Be Determined"
    case inDevelopment = "In Development"
}

enum TypeEnum: String, Codable, Equatable {
    case insignificantSpecial = "insignificant_special"
    case regular = "regular"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

enum APIError: LocalizedError, Hashable, Equatable {
    /// User misuse
    case expected(Error, _ localizedDescription: String? = nil)
    /// Developer issue
    case unexpected(Error, _ localizedDescription: String? = nil)

    public func hash(into hasher: inout Hasher) {
        hasher.combine(errorDescription)
    }

    public static func ==(lhs: APIError, rhs: APIError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }

    public var errorDescription: String? {
        switch self {
        case .expected(let error, let description):
            return description ?? error.localizedDescription
        case .unexpected(let error, let description):
            return description ?? error.localizedDescription
        }
    }

    public var error: Error {
        switch self {
        case .expected(let error, _):
            return error
        case .unexpected(let error, _):
            return error
        }
    }
}


//// MARK: - URLSession response handlers
//
//extension URLSession {
//    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error)
//                completionHandler(nil, response, error)
//                return
//            }
//            do {
//                completionHandler(try newJSONDecoder().decode(T.self, from: data), response, nil)
//            } catch  {
//                completionHandler(nil, response, error)
//            }
//        }
//    }
//
////    func moviesTask(completionHandler: @escaping (Movies?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
////        return self.codableTask(with: URL(string: baseUrl + "schedule")!, completionHandler: completionHandler)
////    }
//}
