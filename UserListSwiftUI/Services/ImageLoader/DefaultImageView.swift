//
//  DefaultImageView.swift
//  UserListSwiftUI
//
//  Created by yura on 09.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import SwiftUI

struct DefaultImageView: View {
   
    var body: some View {
        Image(uiImage: DefaultImageView.defaultImage)
            .resizable()
    }
    
    static var defaultImage = UIImage(systemName: "person.crop.circle.fill")!
    
}

struct DefaultImageView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultImageView()
    }
}
