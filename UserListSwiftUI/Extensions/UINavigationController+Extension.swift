//
//  UINavigationController+Extension.swift
//  UserListSwiftUI
//
//  Created by yura on 03.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topViewController?.hidesBottomBarWhenPushed = true
    }
    
}
