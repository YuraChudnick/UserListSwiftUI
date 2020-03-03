//
//  AvatarView.swift
//  UserListSwiftUI
//
//  Created by yura on 01.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    @Binding var showingImagePicker: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                UrlImageView(imageSize: CGSize(width: 85, height: 85), model: urlImageModel)
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

//struct AvatarView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AvatarView(urlImageModel: UrlImageModel(urlString: "https://randomuser.me/api/portraits/women/88.jpg"), showingImagePicker: <#T##Binding<Bool>#>)
//    }
//}
