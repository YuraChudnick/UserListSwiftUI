//
//  UserDetailView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject var viewModel: UserDetailViewModel
    
    var body: some View {
        List {
            AvatarView(imageLink: viewModel.avatarImage)
                .frame(height: 202, alignment: .center)
        }
        .navigationBarTitle("Edit profile")
        .navigationBarItems(trailing:
            Button("Save") {
                self.viewModel.apply(.onSave)
            }
        )
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(viewModel: UserDetailViewModel(user: User.example))
    }
}
