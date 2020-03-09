//
//  ItemRow.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
 
struct UserRow: View {
        
    @ObservedObject var userDetailViewModel: UserDetailViewModel
    @State private var isActive: Bool = false
    @State private var newImage: UIImage?
    
    var body: some View {
        NavigationLink(destination: UserDetailView(isActive: $isActive, inputImage: $newImage).environmentObject(userDetailViewModel), isActive: $isActive) {
            HStack() {
                AsyncImage(url: userDetailViewModel.user.getAvatarUrl(.medium),
                           placeholder: DefaultImageView(), newImage: $newImage,
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
        UserRow(userDetailViewModel: UserDetailViewModel(user: User.example))
    }
}
