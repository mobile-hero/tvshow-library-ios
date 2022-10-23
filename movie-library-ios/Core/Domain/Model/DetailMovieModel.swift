//
//  DetailTvShowModel.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation
import UIKit

struct DetailTvShowModel {
    let id: Int
    let showId: Int
    var showName: String
    let name: String
    var image: String
    var imageOriginal: String
    let summary: String
    var formattedSummary: NSAttributedString?
    let season: Int
    let number: Int
}
