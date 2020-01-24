//
//  ItemRow.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 24.01.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ItemRow: View {
    
    var item: User
    
    var body: some View {
        List {
            ForEach(0 ..< 5) {_ in
                HStack() {
                    KFImage(self.item.getAvatarUrl(.thumbnail))
                        .frame(width: 40.0, height: 40.0)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(self.item.name?.formattedName ?? "unknown")
                            .font(.headline)
                        Text(self.item.phone)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: User.example)
    }
}
