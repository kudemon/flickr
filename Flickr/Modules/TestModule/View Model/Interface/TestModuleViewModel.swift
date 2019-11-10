//
//  TestModuleViewModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

enum TestModuleViewModelState {
    case loaded([TestModuleCellViewModel])
    case error(Error)
}


protocol TestModuleViewModel {
    var state: Observable<TestModuleViewModelState> { get }
    func flickr()
}
