import Foundation

// MARK: - TvShow
struct TvShow: Codable, Equatable, Identifiable {
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
    let links: TvShowLinks

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary, show
        case links = "_links"
    }
}

typealias TvShows = [TvShow]

// MARK: - Image
struct ImageObject: Codable, Equatable {
    let medium: String
    let original: String
}

// MARK: - TvShowLinks
struct TvShowLinks: Codable, Equatable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable, Equatable {
    let href: String?
}

// MARK: - Rating
struct Rating: Codable, Equatable {
    let average: Double?
}

// MARK: - Show
struct Show: Codable, Equatable {
    let id: Int
    let url: String
    let name, type: String
    let language: String?
    let genres: [String]
    let status: String
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

// MARK: - Externals
struct Externals: Codable, Equatable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

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

// MARK: - Network
struct Network: Codable, Equatable {
    let id: Int
    let name: String
    let country: Country
    let officialSite: String?
}

// MARK: - Country
struct Country: Codable, Equatable {
    let name: String
    let code: String
    let timezone: String
}

// MARK: - Schedule
struct Schedule: Codable, Equatable {
    let time: String
    let days: [String]
}
