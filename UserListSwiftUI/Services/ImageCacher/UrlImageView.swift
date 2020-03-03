//
//  UrlImageView.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.02.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI
import Combine

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    let imageSize: CGSize
    
    init(imageSize: CGSize = CGSize(width: 40, height: 40), model: UrlImageModel) {
        self.imageSize = imageSize
        self.urlImageModel = model
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFill()
            .foregroundColor(Color.gray)
            .frame(width: imageSize.width, height: imageSize.height)
            .clipShape(Circle())
    }
    
    static var defaultImage = UIImage(systemName: "person.crop.circle.fill")
    
}
