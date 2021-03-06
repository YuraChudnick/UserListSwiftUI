//
//  UsersRequest.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation

enum UsersRequest: RequestType {

    typealias Response = UsersResponse
    
    case usersList(quantity: Int)
    case pagination(page: Int, quantity: Int)
    
    var baseUrl: String {
        return "https://randomuser.me"
    }
    
    var path: String {
        return "/api"
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .usersList(quantity):
            return [.init(name: "results", value: "\(quantity)")]
        case let .pagination(page, quantity):
            return [.init(name: "page", value: "\(page)"),
                    .init(name: "results", value: "\(quantity)"),
                    .init(name: "seed", value: "abc")]
        }
    }
    
    func asURLRequest() -> URLRequest? {
        guard let pathURL = URL(string: path, relativeTo: URL(string: baseUrl)), var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        urlComponents.queryItems = queryItems
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
