//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import XCTest
@testable import Flickr

class MockState: AppState {
    func set(photo: Photo, isFav: Bool) {
        
    }
    
    var callback: AppStateCallbacks?
    
    func updatePhoto(id: String, isFav: Bool) {
        
    }
    
    func getPhoto(id: String) -> (Photo, Bool) {
        if id == "48842198372" {
            return (Photo(id: "48842198372",
                          owner: "183936978",
                          secret: "d638519ef7",
                          server: "65535",
                          farm: 66,
                          title: "On fire",
                          ispublic: 1,
                          isfriend: 0,
                          isfamily: 0), true)
        } else {
            XCTFail()
            fatalError()
        }
    }
}

class FlickrTests: XCTestCase {
    
    private var viewModel: DetailsViewModelImpl!
    private let ethalonURL = URL(string: "https://farm66.staticflickr.com/65535/48842198372_d638519ef7_b.jpg")!
    
    override func setUp() {
        viewModel = DetailsViewModelImpl(state: MockState())
    }

    override func tearDown() {
        viewModel = nil
    }

    func testURLFormatting() {
        viewModel.getPhoto(id: "48842198372")
        XCTAssert(ethalonURL == viewModel.url)
    }
    
    
}
