//
//  ItemRow.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct UserRow: View {
    
    @State var user: User
    
    var body: some View {
        HStack() {
            //KFImage(user.getAvatarUrl(.thumbnail))
            Image(systemName: "person")
                .foregroundColor(Color.gray)
                .frame(width: 40.0, height: 40.0)
                .clipShape(Circle())
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

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: User.example)
    }
}
