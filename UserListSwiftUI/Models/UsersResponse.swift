//
//  UsersResponse.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    
    var results: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
