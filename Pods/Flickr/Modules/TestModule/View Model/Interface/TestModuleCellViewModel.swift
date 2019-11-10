//
//  TestModuleCellViewModel.swift
//  Flickr
//
//  Created by nikita on 15/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

protocol TestModuleCellViewModel {
    var id: String { get }
    var url: URL { get }
    var title: String { get }
    var isFav: Observable<Bool> { get set }
    
    func like()
}
