//
//  PhotoViewerApp.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import SwiftUI

@main
struct PhotoViewerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PhotoListView()
            }
        }
    }
}
