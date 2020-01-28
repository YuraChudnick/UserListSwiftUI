//
//  AppView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            UsersView(viewModel: .init())
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Users")
            }
            SavedUsersView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Saved")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
