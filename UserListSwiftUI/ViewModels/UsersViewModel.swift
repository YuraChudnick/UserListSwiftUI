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
    
    //MARK: - Output
    
    @Published private(set) var users: [User] = [User.example]
    
}
