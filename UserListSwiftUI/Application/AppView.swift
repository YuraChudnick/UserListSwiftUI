//
//  AppView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    @State private var selection = 0
    let usersViewModel: UsersViewModel = .init()
    let savedUsersViewModel: SavedUsersViewModel = .init()
    
    var body: some View {
        TabView(selection: $selection) {
            UsersView(viewModel: usersViewModel)
            .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Users")
            }.tag(0)
            
            SavedUsersView(viewModel: savedUsersViewModel)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Saved")
            }.tag(1)
        }
        .edgesIgnoringSafeArea(.top)
//        NavigationView {
//            
//            .navigationBarTitle(Text(selection == 0 ? "Users" : "Saved users"), displayMode: .inline)
//        }
    }
    
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
