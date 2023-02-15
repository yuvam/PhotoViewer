//
//  PhotoListView.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import SwiftUI

struct PhotoListView: View {
    
    @ObservedObject var viewModel = PhotoListViewModel()
    
    var body: some View {
        List {
            ForEach($viewModel.photos) { $photo in
                HStack {
                    NavigationLink(destination: PhotoDetailView(photo: $photo)) {
                        PhotoListItemView(photo: $photo)
                            .onAppear {
                                viewModel.loadMorePhotosIfNeeded(currentPhoto: photo)
                            }
                    }
                }
                .listRowSeparator(.hidden)
                Divider()
            }
            if viewModel.isLoading {
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Photos")
        .onAppear {
            viewModel.loadMorePhotos()
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
