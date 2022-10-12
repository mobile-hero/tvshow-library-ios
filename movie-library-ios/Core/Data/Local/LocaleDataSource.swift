//
//  LocaleDataSource.swift
//  movie-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    func getFavorites() -> AnyPublisher<FavoriteMovieEntities, Error>
    func add(movie: FavoriteMovieEntity) -> AnyPublisher<Bool, Error>
    func remove(movie: FavoriteMovieEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realm in
        return LocaleDataSource(realm: realm)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavorites() -> AnyPublisher<FavoriteMovieEntities, Error> {
        return Future<FavoriteMovieEntities, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            let movies: Results<FavoriteMovieEntity> = {
                realm.objects(FavoriteMovieEntity.self).sorted(byKeyPath: "name")
            }()
            completion(.success(movies.toArray(ofType: FavoriteMovieEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    func add(movie: FavoriteMovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            do {
                try realm.write {
                    realm.add(movie)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func remove(movie: FavoriteMovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            do {
                try realm.write {
                    realm.delete(movie)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
