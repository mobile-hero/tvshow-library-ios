//
//  FavoriteTvShow.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift

class FavoriteTvShowEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var showId: Int = 0
    @objc dynamic var showName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var imageOriginal: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var season: Int = 0
    @objc dynamic var number: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

typealias FavoriteTvShowEntities = [FavoriteTvShowEntity]
