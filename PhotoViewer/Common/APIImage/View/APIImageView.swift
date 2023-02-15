//
//  APIImageView.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation
import SwiftUI

struct APIImageView<PlaceholderImage: View, Content: View>: View {
    
    private var url: URL
    private let placeholderImage: () -> PlaceholderImage
    private let image: (Image) -> Content

    @ObservedObject private var viewModel: APIImageViewModel
    @State private var imageData: Data?

    init(url: URL,
         @ViewBuilder placeholderImage: @escaping () -> PlaceholderImage,
         @ViewBuilder image: @escaping (Image) -> Content
    ) {
        self.url = url
        self.placeholderImage = placeholderImage
        self.image = image
        self.viewModel = APIImageViewModel(url: url, cache: Environment(\.imageCache).wrappedValue)
    }

    @ViewBuilder private var imageContent: some View {
        if let data = imageData, let actualImage = UIImage(data: data) {
            image(Image(uiImage: actualImage))
        } else {
            placeholderImage()
        }
    }

    var body: some View {
        imageContent
            .onReceive(viewModel.$imageData) { imageData in
                self.imageData = imageData
            }
    }
}
