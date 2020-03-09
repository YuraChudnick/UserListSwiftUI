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
                }
                .onAppear(perform: { self.viewModel.listItemAppears(user) })
            }
            .pullToRefresh(isShowing: $viewModel.isRefreshing, onRefresh: onRefresh)
            .navigationBarTitle("Users", displayMode: .inline)
            .onAppear(perform: { self.viewModel.apply(.onAppear) })
            .alert(isPresented: $viewModel.isErrorShown) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("Close")))
            }
        }
    }
    
    private func onRefresh() {
        viewModel.apply(.onLoadData)
    }
    
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(viewModel: .init())
    }
}
