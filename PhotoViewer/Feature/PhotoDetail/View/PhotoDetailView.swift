//
//  PhotoDetailView.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import SwiftUI

struct PhotoDetailView: View {
    
    @Binding var photo: Photo
    var body: some View {
        VStack {
            let thumbnail: URL = .init(stringLiteral: photo.url.stringValue)
            APIImageView(url: thumbnail, placeholderImage: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 5))
            }, image: {
                $0.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 5))
            })
            VStack {
                HStack {
                    Text("Photo Title")
                        .font(.system(.headline))
                    Spacer()
                }
                TextField("Enter photo title", text: $photo.title.defaultValue(.empty), axis: .vertical)
                    .lineLimit(...5)
                    .textFieldStyle(.roundedBorder)
            }.padding([.top], 50)
            Spacer()
        }
        .padding()
    }
}
