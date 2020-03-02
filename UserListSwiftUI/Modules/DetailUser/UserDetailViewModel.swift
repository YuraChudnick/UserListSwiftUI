//
//  UserDetailViewModel.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
import Combine

final class UserDetailViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    private let user: User
    private let realmProvider: RealmProvider
    
    @Published var paramaterViewModels: [ParameterViewModel] = []
    
    // MARK: - Input
    
    enum Input {
        case onSave
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onSave:
            break
        }
    }
    
    var avatarImage: String? {
        return user.picture?.large
    }
    
    init(user: User, realmProvider: RealmProvider = .users) {
        self.user = user
        self.realmProvider = realmProvider
        paramaterViewModels = [ParameterViewModel(type: .firstName, value: user.name?.first ?? ""),
                               ParameterViewModel(type: .lastName, value: user.name?.last ?? ""),
                               ParameterViewModel(type: .email, value: user.email),
                               ParameterViewModel(type: .phoneNumber, value: user.phone)]
    }
    
}
