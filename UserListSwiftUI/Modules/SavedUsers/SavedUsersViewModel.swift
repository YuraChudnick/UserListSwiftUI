//
//  SavedUsersViewModel.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 02.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Combine
import RealmSwift
import Foundation

final class SavedUsersViewModel: ObservableObject {
    
    private var isViewDidLoad: Bool = false
    private let realmProvider: RealmProvider
    
    private var usersResults: Results<User>?
    private var notificationToken: NotificationToken?
    
    // MARK: - Input
    
    enum Input {
        case onAppear
        case onDelete(offsets: IndexSet)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            if !isViewDidLoad {
                isViewDidLoad = true
                loadData()
            }
        case .onDelete(let offsets):
            var toDelete: [User] = []
            for index in offsets {
                toDelete.append(savedUsers[index])
            }
            savedUsers.remove(atOffsets: offsets)
            DispatchQueue.main.async {
                User.remove(users: toDelete, in: self.realmProvider)
            }
        }
    }
    
    // MARK: - Output
    
    @Published private(set) var savedUsers: [User] = []
    
    // MARK: Init
    
    init(realmProvider: RealmProvider = .users) {
        self.realmProvider = realmProvider
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // MARK: - Realm observer
    
    fileprivate func loadData() {
        usersResults = realmProvider.realm.objects(User.self)
        notificationToken = usersResults?.observe({ (changes) in
            switch changes {
            case let .initial(results):
                self.savedUsers = Array(results)
            case let .update(results, deletions, _, _):
                guard deletions.isEmpty else { return }
                self.savedUsers = Array(results)
            case .error(let error):
                print(error)
            }
        })
    }
    
}
