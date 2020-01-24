//
//  Name.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import RealmSwift

@objcMembers class Name: Object, Codable {
    
    dynamic var title: String = ""
    dynamic var first: String = ""
    dynamic var last: String  = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case first
        case last
    }
    
    #if DEBUG
    static let example: Name = {
        let name = Name()
        name.first = "Harry"
        name.last = "Potter"
        name.title = "Harry Potter"
        return name
    }()
    #endif
    
}

extension Name {
    
    var formattedName: String {
        return first.capitalizingFirstLetter() + " " + last.capitalizingFirstLetter()
    }
    
}
