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
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                UsersView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Users")
                }.tag(0)
                SavedUsersView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Saved")
                }.tag(1)
            }
            .navigationBarTitle(Text(selection == 0 ? "Users" : "Saved users"), displayMode: .inline)
        }
    }
    
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
