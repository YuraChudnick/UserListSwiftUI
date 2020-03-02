//
//  SavedUsersView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct SavedUsersView: View {
    
    @ObservedObject var viewModel: SavedUsersViewModel
    
    var body: some View {
        NavigationView {
//            ForEach(viewModel.savedUsers, id: \.self) { user in
//                UserRow(user: user)
//            }.onDelete(perform: { index in
//                print(index)
//            })
            List(viewModel.savedUsers) { user in
                UserRow(user: user)
            }
            .navigationBarTitle(Text("Saved users"), displayMode: .inline)
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

struct SavedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        SavedUsersView(viewModel: SavedUsersViewModel())
    }
}
