//
//  PhotosListAPI.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

enum PhotosListAPI: APIRequestable {
    
    typealias ResponseType = [Photo]
    
    case photos(request: PhotosPaginationRequest)
    
    var path: String? { "/photos" }
    
    var queryParameters: [String : Any]? {
        switch self {
            case .photos(let request): return request.toDictionary()
        }
    }
}
