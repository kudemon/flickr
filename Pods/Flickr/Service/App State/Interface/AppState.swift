//
//  AppState.swift
//  Flickr
//
//  Created by nikita on 15/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation
import CoreData

protocol AppStateCallbacks {
    func photoDidChange(_ photo: Photo, isFav: Bool)
}

protocol AppState {
    var callbacks: [AppStateCallbacks] { get set }

    func set(photo: Photo, isFav: Bool)
    func updatePhoto(id: String, isFav: Bool)
    func getPhoto(id: String) -> (Photo, Bool)
}

extension AppState {
    func set(photo: Photo) {
        self.set(photo: photo, isFav: false)
    }
}
