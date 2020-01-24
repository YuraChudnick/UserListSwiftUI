//
//  Picture.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import RealmSwift

@objcMembers class Picture: Object, Codable {
    
    dynamic var large: String = ""
    dynamic var medium: String = ""
    dynamic var thumbnail: String = ""
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
    
    #if DEBUG
    static let example: Picture = {
        let picture = Picture()
        return picture
    }()
    #endif
    
}
