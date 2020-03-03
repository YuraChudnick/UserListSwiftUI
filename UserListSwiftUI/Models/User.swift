//
//  User.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import RealmSwift

enum AvatarSize {
    case large
    case medium
    case thumbnail
}

enum UserDataError: Error {
    case noLargeURL
    case noMediumURL
    case noThumbnailURL
}

@objcMembers class User: Object, Codable, Identifiable {
    
    dynamic var gender: String = ""
    dynamic var name: Name? = nil
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var picture: Picture? = nil
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case email
        case phone
        case picture
    }
    
}

extension User {
    
    func makeCopy(newValues: (first: String, last: String, email: String, phone: String, image: String)) -> User {
        let user = User()
        user.name = Name()
        user.picture = Picture()
        user.gender = gender
        user.name?.first        = newValues.first
        user.name?.last         = newValues.last
        user.email              = newValues.email
        user.phone              = newValues.phone
        user.picture?.large     = newValues.image
        user.picture?.medium    = newValues.image
        user.picture?.thumbnail = newValues.image
        return user
    }
    
    func fill(with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        self.name?.first        = newValues.first
        self.name?.last         = newValues.last
        self.email              = newValues.email
        self.phone              = newValues.phone
        self.picture?.large     = newValues.image
        self.picture?.medium    = newValues.image
        self.picture?.thumbnail = newValues.image
    }
    
    func getAvatarUrl(_ avatarSize: AvatarSize) -> URL? {
        switch avatarSize {
        case .large:
            guard let large = picture?.large, let url = URL(string: large) else {
                return nil
            }
            return url
        case .medium:
            guard let medium = picture?.medium, let url = URL(string: medium) else {
                return nil
            }
            return url
        case .thumbnail:
            guard let thumbnail = picture?.thumbnail, let url = URL(string: thumbnail) else {
                return nil
            }
            return url
        }
    }
    
    func getAvatarKey(_ avatarSize: AvatarSize) -> String {
        switch avatarSize {
        case .large:
            return picture?.large ?? ""
        case .medium:
            return picture?.medium ?? ""
        case .thumbnail:
            return picture?.thumbnail ?? ""
        }
    }
    
    func update(in realmProvider: RealmProvider = RealmProvider.users, with newValues: (first: String, last: String, email: String, phone: String, image: String)) {
        let realm = realmProvider.realm
        do {
            try realm.write {
                fill(with: newValues)
            }
        } catch {
            print(error)
        }
    }
    
    func save(in realmProvider: RealmProvider = RealmProvider.users) {
        guard realm == nil else { return }
        let realm = realmProvider.realm
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print(error)
        }
    }
    
    func remove(in realmProvider: RealmProvider = RealmProvider.users) {
        let realm = realmProvider.realm
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {
            print(error)
        }
    }
    
    static func loadUsers() -> [User] {
        let users = RealmProvider.users.realm.objects(User.self)
        var result: [User] = []
        users.forEach { result.append($0) }
        return result
    }
    
    #if DEBUG
    static let example: User = {
        let user = User()
        user.gender = "man"
        user.email = "swift@apple.com"
        user.name = Name.example
        user.phone = "+380999999999"
        user.picture = Picture.example
        return user
    }()
    #endif
    
}
