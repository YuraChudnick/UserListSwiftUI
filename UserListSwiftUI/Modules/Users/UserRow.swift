//
//  ItemRow.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
 
struct UserRow: View {
        
    @EnvironmentObject var userDetailViewModel: UserDetailViewModel
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationLink(destination: UserDetailView(isActive: $isActive).environmentObject(userDetailViewModel), isActive: $isActive) {
            HStack() {
                AsyncImage(url: userDetailViewModel.user.getAvatarUrl(.medium),
                           placeholder: DefaultImageView(),
                           cache: userDetailViewModel.cache, configuration: { $0.resizable() })
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(userDetailViewModel.user.name?.formattedName ?? "unknown")
                        .font(.headline)
                    Text(userDetailViewModel.user.phone)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
        }
        .isDetailLink(false)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow().environmentObject(UserDetailViewModel(user: User.example))
    }
}
