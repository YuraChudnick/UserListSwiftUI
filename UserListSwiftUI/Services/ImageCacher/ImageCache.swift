//
//  ImageCache.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.02.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
