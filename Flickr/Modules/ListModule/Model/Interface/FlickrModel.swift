//
//  TestModuleModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

enum FlickrModelState {
    case loaded([Photo])
    case error(Error)
    case changed(Photo, Bool)
}

protocol FlickrModel {
    var state: Observable<FlickrModelState> { get }
    func loadFlickr()
    func like(id: String, liked: Bool)
}
