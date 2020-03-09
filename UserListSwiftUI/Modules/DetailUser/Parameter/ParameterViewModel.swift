//
//  ParameterViewModel.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 02.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Combine

class ParameterViewModel: ObservableObject, Identifiable {
    
    let type: ParameterType
    @Published var value: String
    
    init(type: ParameterType, value: String) {
        self.type = type
        self.value = value
    }
    
}
