//
//  ImageCache.swift
//  UserListSwiftUI
//
//  Created by Yurii Chudnovets on 27.02.2020.
//  Copyright © 2020 Yurii Chudnovets. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

class TemporaryImageCache: ImageCache {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

extension TemporaryImageCache {
    private static var imageCache = TemporaryImageCache()
    static func getImageCache() -> TemporaryImageCache {
        return imageCache
    }
}
