//
//  UsersView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                VStack(alignment: .center) {
                    UserRow(userDetailViewModel: UserDetailViewModel(user: user))
                    if self.viewModel.isRefreshing && self.viewModel.users.isLastItem(user) {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
                }.onAppear {
                    self.viewModel.listItemAppears(user)
                }
            }
            .pullToRefresh(isShowing: $viewModel.isRefreshing, onRefresh: {
                print("StartRefreshing")
                self.viewModel.apply(.onLoadData)
            })
            .navigationBarTitle("Users", displayMode: .inline)
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(viewModel: .init())
    }
}
