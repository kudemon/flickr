//
//  TestModuleCellViewModelImpl.swift
//  Flickr
//
//  Created by nikita on 15/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class TestModuleCellViewModelImpl: TestModuleCellViewModel {
    let id: String
    let url: URL
    let title: String
    var isFav: Observable<Bool>
    
    init?(photo: Photo) {
        guard let photoURL =
            URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg") else {
            return nil
        }
        
        url = photoURL
        title = photo.title
        id = photo.id
        let obs = Observable<Bool>()
        obs.value = false
        isFav = obs // false
    }
    
    func like() {
        guard let boolean = isFav.value else { return }
        
        isFav.value = !boolean
    }
}
