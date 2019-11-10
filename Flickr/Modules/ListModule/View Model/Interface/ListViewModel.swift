//
//  TestModuleViewModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

enum ListViewModelState {
    case loaded([FlickrPostViewModel])
    case error(Error)
}


protocol ListViewModel {
    var state: Observable<ListViewModelState> { get }
    func flickr()
}
