//
//  DetailMovieModel.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 15/10/22.
//

import Foundation
import UIKit

struct DetailMovieModel {
    let id: Int
    let showId: Int
    var showName: String
    let name: String
    var image: String
    var imageOriginal: String
    let summary: String
    let season: Int
    let number: Int
    
    var formattedSummary: NSAttributedString {
        let attStr = try! NSMutableAttributedString(data: summary.data(using: .utf8)!,
                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                             documentAttributes: nil)
        
        attStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attStr.length))
        
        return attStr
    }
}
