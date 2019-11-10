//
//  TestModuleModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

enum TestModuleModelState {
    case loaded([Photo])
    case error(Error)
    case changed(Photo, Bool)
}

protocol TestModuleModel {
    var state: Observable<TestModuleModelState> { get }
    func loadFlickr()
    func like(id: String, liked: Bool)
}
