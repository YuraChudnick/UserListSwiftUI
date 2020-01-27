//
//  RequestType.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype Response: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    
    func asURLRequest() -> URLRequest?
}
