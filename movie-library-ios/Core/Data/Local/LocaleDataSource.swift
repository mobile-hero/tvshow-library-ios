//
//  LocaleDataSource.swift
//  tvShow-library-ios
//
//  Created by Majoo Apple  on 26/09/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    func getFavorites() -> AnyPublisher<FavoriteTvShowEntities, Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func add(tvShow: FavoriteTvShowEntity) -> AnyPublisher<Bool, Error>
    func remove(id: Int) -> AnyPublisher<Bool, Error>
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
    func getFavorites() -> AnyPublisher<FavoriteTvShowEntities, Error> {
        return Future<FavoriteTvShowEntities, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            let tvShows: Results<FavoriteTvShowEntity> = {
                realm.objects(FavoriteTvShowEntity.self).sorted(byKeyPath: "name")
            }()
            completion(.success(tvShows.toArray(ofType: FavoriteTvShowEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    private func getObject(id: Int) -> FavoriteTvShowEntity? {
        return realm?.object(ofType: FavoriteTvShowEntity.self, forPrimaryKey: id)
    }
    
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
//            do {
//                let result = realm.object(ofType: FavoriteTvShowEntity.self, forPrimaryKey: id)
//                print(result)
//                completion(.success(result != nil))
//            } catch {
//                completion(.failure(DatabaseError.requestFailed))
//            }
            let result = self.getObject(id: id)
            print(result)
            completion(.success(result != nil))
        }.eraseToAnyPublisher()
    }
    
    func add(tvShow: FavoriteTvShowEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            do {
                try realm.write {
                    realm.add(tvShow)
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func remove(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let realm = self.realm else {
                completion(.failure(DatabaseError.invalidInstance))
                return
            }
            
            do {
                try realm.write {
                    let object = self.getObject(id: id)!
                    realm.delete(object)
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
