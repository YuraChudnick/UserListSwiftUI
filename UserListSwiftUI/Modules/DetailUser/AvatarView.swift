//
//  AvatarView.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    
    @State var imageLink: String?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                UrlImageView(imageSize: CGSize(width: 85, height: 85), urlString: imageLink)
                Button("Change avatar") {
                    print("pressed")
                }
                .font(.subheadline)
                .foregroundColor(Color.blue)
                
            }
            Spacer()
        }
    }
    
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(imageLink: "https://randomuser.me/api/portraits/women/88.jpg")
    }
}
