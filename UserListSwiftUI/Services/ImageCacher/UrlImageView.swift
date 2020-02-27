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
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.gray)
            .frame(width: 40.0, height: 40.0)
            .clipShape(Circle())
    }
    
    static var defaultImage = UIImage(systemName: "person.crop.circle.fill")
    
}
