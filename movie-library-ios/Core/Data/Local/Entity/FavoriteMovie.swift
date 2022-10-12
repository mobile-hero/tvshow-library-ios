//
//  FavoriteMovie.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift

class FavoriteMovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var summary: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

typealias FavoriteMovieEntities = [FavoriteMovieEntity]
