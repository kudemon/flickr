//
//  DetailsViewModelImpl.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class DetailsViewModelImpl: DetailsViewModel {
    private let state: AppState
    private let photo: Photo
    
    init(state: AppState, photoId: String) {
        self.photo = state.getPhoto(id: photoId).0
        self.state = state
    }
    
    var id: String {
        return photo.id
    }
    
    var owner: String {
        return photo.owner
    }
    
    var ispublic: Int {
        return photo.ispublic
    }
    
    var isfriend: Int {
        return photo.isfriend
    }
    
    var isfamily: Int {
        return photo.isfamily
    }
    
    var title: String {
        return photo.title
    }
    
    var url: URL? {
        return URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg")
    }
    var isFav: Bool  {
        get {
            return state.getPhoto(id: photo.id).1
        }
        set {
            print("\(#function) \(newValue)")
            state.updatePhoto(id: photo.id, isFav: isFav)
            favButtonTitle.value = isFav ? "❤️ Лайк" : "♡ Лайк"
        }
    }
    
    var favButtonTitle: Observable<String> = Observable<String>()
   

    
}
