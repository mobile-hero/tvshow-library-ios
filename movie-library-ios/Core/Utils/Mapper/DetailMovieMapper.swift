//
//  DetailTvShowMapper.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation
import UIKit

final class DetailTvShowMapper {
    static func mapTvShowResponseToDomain(input origin: TvShow) -> DetailTvShowModel {
        let summary = origin.summary ?? "No summary available"
        let attStr = try! NSMutableAttributedString(data: summary.data(using: .utf8)!,
                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                             documentAttributes: nil)
        
        attStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attStr.length))
        
        return DetailTvShowModel(
            id: origin.id,
            showId: origin.show?.id ?? -1,
            showName: "",
            name: origin.name,
            image: origin.image?.medium ?? origin.show?.image?.medium ?? "-",
            imageOriginal: origin.image?.original ?? origin.show?.image?.original ?? "-",
            summary: summary,
            formattedSummary: attStr,
            season: origin.season ?? 0,
            number: origin.number ?? 0)
    }
    
    static func mapTvShowDomainToEntity(input origin: DetailTvShowModel) -> FavoriteTvShowEntity {
        let result = FavoriteTvShowEntity()
        result.id = origin.id
        result.showId = origin.showId
        result.showName = origin.showName
        result.name = origin.name
        result.image = origin.image
        result.imageOriginal = origin.imageOriginal
        result.summary = origin.summary
        result.season = origin.season
        result.number = origin.number
        return result
    }
}
