//
//  APIImageViewModel.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

class APIImageViewModel: ObservableObject {
    @Published var imageData = Data()
    private var cache: ImageCache?
    
    convenience init(url: URL, cache: ImageCache?) {
        self.init()
        self.cache = cache
        loadImageData(for: url)
    }

    func loadImageData(for url: URL) {
        if let nsdata = cache?[url] {
            imageData = Data(referencing: nsdata)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
                self.cache(data: data, for: url)
            }
        }
        task.resume()
    }
    
    private func cache(data: Data, for url: URL) {
        let nsdata = NSData(data: data)
        cache?[url] = nsdata
    }
}
