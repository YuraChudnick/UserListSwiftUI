//
//  UserDetailViewModel.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Combine

final class UserDetailViewModel: ObservableObject {
    
    
    // MARK: - Input
    
    enum Input {
        case onSave
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onSave:
            save()
        }
    }
    
    // MARK: - Output
    
    @Published var paramaterViewModels: [ParameterViewModel] = []
    @Published var user: User
    
    private let realmProvider: RealmProvider
    let cache = TemporaryImageCache.getImageCache()
    
    // MARK: - Init
    
    init(user: User, realmProvider: RealmProvider = .users) {
        self.user = user
        self.realmProvider = realmProvider
        paramaterViewModels = [ParameterViewModel(type: .firstName, value: user.name?.first ?? ""),
                               ParameterViewModel(type: .lastName, value: user.name?.last ?? ""),
                               ParameterViewModel(type: .email, value: user.email),
                               ParameterViewModel(type: .phoneNumber, value: user.phone)]
    }
    
    // MARK: - Actions
    
    private func save() {
        if user.realm != nil {
            user.update(in: realmProvider,
            with: (first: paramaterViewModels[0].value,
                   last: paramaterViewModels[1].value,
                   email: paramaterViewModels[2].value,
                   phone: paramaterViewModels[3].value,
                   image: user.picture?.large ?? ""))
        } else {
            user
                .makeCopy(newValues: (first: paramaterViewModels[0].value,
                                      last: paramaterViewModels[1].value,
                                      email: paramaterViewModels[2].value,
                                      phone: paramaterViewModels[3].value,
                                      image: user.picture?.large ?? ""))
                .save(in: realmProvider)
        }
    }
    
}
