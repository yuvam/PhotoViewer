//
//  PhotoListItemView.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation
import SwiftUI

struct PhotoListItemView: View {
    
    @Binding var photo: Photo
    
    var body: some View {
        let thumbnail: URL = .init(stringLiteral: photo.thumbnailURL.stringValue)
        APIImageView(url: thumbnail, placeholderImage: {
            Image(systemName: "photo")
                .frame(width: 80, height: 80)
        }, image: {
            $0.frame(width: 80, height: 80)
            .clipShape(Circle())
        })
        Text(photo.title.stringValue)
        .font(.system(.subheadline))
        .padding()
    }
}
