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
    }
    
}
