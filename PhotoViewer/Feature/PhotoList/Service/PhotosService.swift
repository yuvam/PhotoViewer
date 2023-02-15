//
//  PhotosService.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

protocol PhotosServiceDelegate {
    func getPhotos(at page: Int, limit: Int) async -> (value: [Photo]?, error: Error?)
}

class PhotosService: PhotosServiceDelegate {
    
    func getPhotos(at page: Int, limit: Int) async -> (value: [Photo]?, error: Error?) {
        let result = await APIClient.fetch(request: PhotosListAPI.photos(request: .init(page: page, limit: limit)))
        return (result.value, result.error)
    }
}
