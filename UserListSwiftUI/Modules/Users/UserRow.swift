//
//  ItemRow.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
 
struct UserRow: View {
    
    @State var user: User
    
    var body: some View {
        NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: user))) {
            HStack() {
                UrlImageView(model: UrlImageModel(urlString: user.picture?.medium))
                VStack(alignment: .leading) {
                    Text(user.name?.formattedName ?? "unknown")
                        .font(.headline)
                    Text(user.phone)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: User.example)
    }
}
