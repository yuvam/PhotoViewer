//
//  PhotoListViewModel.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

class PhotoListViewModel: ObservableObject {
    
    private let photosService: PhotosServiceDelegate
    
    @Published var photos = [Photo]()
    @Published var isLoading = false
    var currentPage = 1
    
    //Constants
    private let totalPhotos = 5000
    private let threshold = 2
    private let photosPerPage = 10
    private var totalPages: Int { totalPhotos / photosPerPage }
    
    var hasNextPage: Bool {
        currentPage < totalPages
    }
    
    private var currentTask: Task<Void, Never>? {
        willSet {
            if let task = currentTask {
                if task.isCancelled { return }
                task.cancel()
            }
        }
    }
    
    init(photosService: PhotosServiceDelegate = PhotosService()) {
        self.photosService = photosService
    }
    
    func loadMorePhotosIfNeeded(currentPhoto photo: Photo?) {
        guard let photo else {
            loadMorePhotos()
          return
        }

        let thresholdIndex = photos.index(photos.endIndex, offsetBy: -threshold)
        if photos.firstIndex(where: { $0.id == photo.id }) == thresholdIndex {
            loadMorePhotos()
        }
      }

    func loadMorePhotos() {
        guard !isLoading && hasNextPage else {
          return
        }
        isLoading.toggle()
        currentTask = Task {
            let result = await self.photosService.getPhotos(at: self.currentPage, limit: self.photosPerPage)
            DispatchQueue.main.async {
                if let response = result.value { self.photos += response }
                self.currentPage += 1
                self.isLoading.toggle()
            }
        }
      }
}
