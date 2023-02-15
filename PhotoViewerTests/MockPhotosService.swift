//
//  MockPhotosService.swift
//  PhotoViewerTests
//
//  Created by iMAC on 15/02/23.
//

import Foundation
@testable import PhotoViewer

class MockPhotosService: PhotosServiceDelegate {
    
    var mockPhotos: [Photo]? = Utility.readBundleJson(fileName: "photos")
    //FIXME: Update Page logic dynamically
//    let photosPerPage = 10
//    var totalPages: Int { mockPhotos?.count ?? 0 / photosPerPage }
    func getPhotos(at page: Int, limit: Int) async -> (value: [Photo]?, error: Error?) {
         return (mockPhotos, nil)
    }
}

struct Utility {
    
    static func readBundleJson<T: Decodable>(fileName: String) -> T? {
        
        guard let resource = Bundle(for: MockPhotosService.self).url(forResource: fileName, withExtension: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: resource) else { return nil }
        guard let model = try? JSONDecoder().decode(T.self, from: jsonData) else { return nil }
        return model
    }
}
