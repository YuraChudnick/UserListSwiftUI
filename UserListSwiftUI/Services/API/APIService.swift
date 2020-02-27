//
//  ApiService.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import Combine

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: RequestType
}

final class APIService: APIServiceType {
    
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : RequestType {
        
        guard let request = request.asURLRequest() else {
            let errorPublisher = Result<Request.Response, APIServiceError>.Publisher(APIServiceError.badRequestError)
            return errorPublisher.eraseToAnyPublisher()
        }
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
