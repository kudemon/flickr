//
//  DictionaryState.swift
//  Flickr
//
//  Created by nikita on 15/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class DictionaryState: AppState {
    static let shared = DictionaryState()
    
    init() {}
    
    class Handle {
        var isFav = false
        let photo: Photo
        
        init(photo: Photo, isFav: Bool = false) {
            self.photo = photo
            self.isFav = isFav
        }
    }
    
    private var backDictionary: [String: Handle] = [:]
    var callbacks = [AppStateCallbacks]()
    
    func set(photo: Photo, isFav: Bool = false) {
        backDictionary[photo.id] = Handle(photo: photo, isFav: isFav)
    }
    
    func updatePhoto(id: String, isFav: Bool) {
        guard let handle = backDictionary[id] else {
            fatalError()
        }

        handle.isFav = isFav
        print("\(#function) \(isFav) \(callbacks.count)")
        callbacks.forEach { $0.photoDidChange(handle.photo, isFav: isFav) }
    }
    
    func getPhoto(id: String) -> (Photo, Bool) {
        guard let handle = backDictionary[id] else {
            fatalError()
        }
        return (handle.photo, handle.isFav)
    }

    
}
