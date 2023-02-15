//
//  PhotoViewerTests.swift
//  PhotoViewerTests
//
//  Created by iMAC on 15/02/23.
//

import XCTest
import Combine
@testable import PhotoViewer

final class PhotoViewerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPhotoListVMSuccessCase() {
        let viewModel = PhotoListViewModel(photosService: MockPhotosService())
        XCTAssertEqual(viewModel.photos.count, 0)
        XCTAssertEqual(viewModel.hasNextPage, true)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.currentPage, 1)
        
        let expectation = XCTestExpectation(description: "loading photos")
        _ = viewModel.$photos.sink(receiveValue: { photos in
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        })
        viewModel.loadMorePhotosIfNeeded(currentPhoto: nil)
        wait(for: [expectation], timeout: 5)
        XCTAssertNotEqual(viewModel.photos.count, 0)
        XCTAssertEqual(viewModel.currentPage, 2)
        let currentPhotos = viewModel.photos.count
        viewModel.loadMorePhotosIfNeeded(currentPhoto: viewModel.photos.last)
        sleep(3)
        XCTAssertEqual(viewModel.photos.count, currentPhotos)
        let thresholdIndex = viewModel.photos.index(viewModel.photos.endIndex, offsetBy: -2)
        viewModel.loadMorePhotosIfNeeded(currentPhoto: viewModel.photos[thresholdIndex])
        sleep(3)
        XCTAssertEqual(viewModel.photos.count, currentPhotos)
    }

}
