//
//  PostEntity.swift
//  Flickr
//
//  Created by nikita on 15/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

// MARK: - FlickrResponse
struct FlickrResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
