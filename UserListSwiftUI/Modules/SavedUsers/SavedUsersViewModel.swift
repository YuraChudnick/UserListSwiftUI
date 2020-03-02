//
//  SavedUsersViewModel.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 02.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

final class SavedUsersViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    private var isViewDidLoad: Bool = false
    private let realmProvider: RealmProvider
    
    private var usersResults: Results<User>?
    private var notificationToken: NotificationToken?
    
    //MARK: Input
    
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            if !isViewDidLoad {
                isViewDidLoad = true
                loadData()
            }
        }
    }
    
    // MARK: Output
    
    @Published private(set) var savedUsers: [User] = []
    
    // MARK: Init
    
    init(realmProvider: RealmProvider = .users) {
        self.realmProvider = realmProvider
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: Setup
    
    fileprivate func loadData() {
        usersResults = realmProvider.realm.objects(User.self)
        notificationToken = usersResults?.observe({ (changes) in
            switch changes {
            case let .initial(results):
                self.savedUsers = Array(results)
            case let .update(results, deletions, insertions, modifications):
                if self.savedUsers.isEmpty {
                    self.savedUsers = Array(results)
                } else if !self.savedUsers.isEmpty && results.isEmpty {
                    self.savedUsers = []
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
}
