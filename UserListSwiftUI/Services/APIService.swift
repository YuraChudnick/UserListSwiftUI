//
//  ApiService.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import Combine

protocol RequestType {
    associatedtype Response: Decodable
    
    var url: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: RequestType
}

final class APIService: APIServiceType {
    
    
    
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : RequestType {
        
    }

}
