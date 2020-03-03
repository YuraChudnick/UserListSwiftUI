//
//  AvatarViewModel.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 02.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Combine

class  AvatarViewModel: ObservableObject {
    
    @Published var image: String?
    
    init(image: String?) {
        self.image = image
    }
    
}
