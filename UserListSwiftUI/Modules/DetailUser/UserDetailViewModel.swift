//
//  UserDetailViewModel.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Combine

final class UserDetailViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    private let realmProvider: RealmProvider
    let cache = TemporaryImageCache.getImageCache()
    
    @Published var paramaterViewModels: [ParameterViewModel] = []
    @Published var user: User
    @Published var isActive: Bool = false
    
    init(user: User, realmProvider: RealmProvider = .users) {
        self.user = user
        self.realmProvider = realmProvider
        paramaterViewModels = [ParameterViewModel(type: .firstName, value: user.name?.first ?? ""),
                               ParameterViewModel(type: .lastName, value: user.name?.last ?? ""),
                               ParameterViewModel(type: .email, value: user.email),
                               ParameterViewModel(type: .phoneNumber, value: user.phone)]
        
        bindInputs()
    }
    
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
    
    private func bindInputs() {
        guard  user.realm == nil else { return }
//        let firstNameSink = paramaterViewModels[0].$value.sink { [weak user] (newValue) in
//            user?.name?.first = newValue
//        }
//        let lastNameSink = paramaterViewModels[1].$value.sink { [weak user] (newValue) in
//            user?.name?.last = newValue
//        }
//        let emailSink = paramaterViewModels[2].$value.sink { [weak user] (newValue) in
//            user?.email = newValue
//        }
//        let phoneSink = paramaterViewModels[3].$value.sink { [weak user] (newValue) in
//            user?.phone = newValue
//        }
        let isActiveSink = $isActive
            .sink { [weak self] newValue in
            if !newValue {
                self?.restore()
            }
        }
        cancellables = [isActiveSink]
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
        isActive = false
    }
    
    private func restore() {
        paramaterViewModels[0].value = user.name?.first ?? ""
        paramaterViewModels[1].value = user.name?.last ?? ""
        paramaterViewModels[2].value = user.email
        paramaterViewModels[3].value = user.phone
    }
    
}
