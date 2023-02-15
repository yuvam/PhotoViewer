//
//  APIImageCache.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation
import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> NSData? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, NSData>()
    
    subscript(_ key: URL) -> NSData? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
