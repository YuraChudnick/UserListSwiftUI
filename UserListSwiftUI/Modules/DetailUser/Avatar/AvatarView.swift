//
//  AvatarView.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    
    @EnvironmentObject var userDetailViewModel: UserDetailViewModel
    @Binding var showingImagePicker: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                AsyncImage(url: userDetailViewModel.user.getAvatarUrl(.large),
                       placeholder: DefaultImageView(),
                       cache: userDetailViewModel.cache, configuration: { $0.resizable() })
                .scaledToFill()
                .frame(width: 85, height: 85)
                .clipShape(Circle())
                Button("Change avatar") {
                    print("pressed")
                    self.showingImagePicker = true
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
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var showingImagePicker: Bool
        
        var body: some View {
            AvatarView(showingImagePicker: $showingImagePicker).environmentObject(UserDetailViewModel(user: User.example))
        }
    }
    
}
