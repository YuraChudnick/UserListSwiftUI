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
            VStack {
                if viewModel.savedUsers.isEmpty {
                  Text("No saved users")
                } else {
                    List {
                        ForEach(viewModel.savedUsers, id: \.self) { user in
                            UserRow(user: user)
                        }.onDelete(perform: { indexSet in
                            if let index = indexSet.first {
                                self.viewModel.apply(.onDelete(index: index))
                            }
                        })
                    }
                }
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
