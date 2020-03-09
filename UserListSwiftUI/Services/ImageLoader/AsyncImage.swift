//
//  AsyncImage.swift
//  UserListSwiftUI
//
//  Created by yura on 09.03.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    @Binding var newImage: UIImage?
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    
    init(url: URL?, placeholder: Placeholder? = nil, newImage: Binding<UIImage?>, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
        self._newImage = newImage
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                if newImage != nil {
                    configuration(Image(uiImage: newImage!))
                        .onAppear(perform: { self.loader.cache(self.newImage!) }) //to do
                } else {
                    configuration(Image(uiImage: loader.image!))
                }
            } else {
                placeholder
            }
        }
    }
}
