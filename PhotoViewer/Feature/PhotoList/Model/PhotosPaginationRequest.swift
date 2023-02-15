//
//  PhotosPaginationRequest.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

struct PhotosPaginationRequest: Encodable {
    let page: Int
    let limit: Int
    enum CodingKeys: String, CodingKey {
        case page = "_page"
        case limit = "_limit"
    }
}
