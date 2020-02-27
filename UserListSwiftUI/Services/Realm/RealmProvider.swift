//
//  RealmProvider.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import RealmSwift

struct RealmProvider {
    let configuration: Realm.Configuration
    
    init(config: Realm.Configuration) {
        configuration = config
    }
    
    var realm: Realm {
        return try! Realm(configuration: configuration)
    }
    
    private static let usersConfig = Realm.Configuration(fileURL: try! Path.inDocuments("users.realm"),
                                                         schemaVersion: 1,
                                                         deleteRealmIfMigrationNeeded: true,
                                                         objectTypes: [User.self, Name.self, Picture.self])
    
    static var users: RealmProvider = {
        RealmProvider(config: usersConfig)
    }()
    
    private static let usersTestConfig = Realm.Configuration(fileURL: try! Path.inDocuments("users_test.realm"),
                                                         schemaVersion: 1,
                                                         deleteRealmIfMigrationNeeded: true,
                                                         objectTypes: [User.self, Name.self, Picture.self])
    
    static var usersTest: RealmProvider = {
        RealmProvider(config: usersTestConfig)
    }()
    
}
