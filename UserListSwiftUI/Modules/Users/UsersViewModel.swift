//
//  UsersViewModel.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class UsersViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Input
    
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send(())
        }
    }
    
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Output
    
    @Published private(set) var users: [User] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isRefreshing = false
    private var page = 0
    
    private let responseSubject = PassthroughSubject<UsersResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    private let apiService: APIServiceType
    
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: UsersRequest.pagination(page: self.page, quantity: 20))
                    .catch { [weak self] error -> Empty<UsersResponse, Never> in
                        self?.isRefreshing = false
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        cancellables += [
            responseStream
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map { $0.results }
            .sink(receiveValue: { [weak self] (newUsers) in
                guard let `self` = self else { return }
                self.isRefreshing = false
                self.page += 1
                self.users += newUsers
            })
            //.assign(to: \.users, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                case .badRequestError: return "bad request error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        
        cancellables += [
            repositoriesStream,
            errorMessageStream
        ]
    }
    
}
