//
//  Post.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

struct PostWrapper: Decodable {
    let posts: [Post]
    
    enum CodingKeys: CodingKey {
        case photos
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        posts = try photos.decode([Post].self, forKey: .photo)
    }
    
}

struct Post: Decodable {
    let url: URL
    let title: String
    
    enum CodingKeys: CodingKey {
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case ispublic
        case isfriend
        case isfamily
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let farm = try values.decode(Int.self, forKey: .farm)
        let server = try values.decode(String.self, forKey: .server)
        let id = try values.decode(String.self, forKey: .id)
        let secret = try values.decode(String.self, forKey: .secret)
        let title = try values.decode(String.self, forKey: .title)
        
        self.url = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg")!
        self.title = title
    }
}
