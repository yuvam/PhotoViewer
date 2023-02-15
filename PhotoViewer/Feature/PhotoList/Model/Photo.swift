//
//  Photo.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

struct Photo: Codable, Identifiable {
    let albumID, id: Int?
    var title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
