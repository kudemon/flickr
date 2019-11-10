//
//  DetailsAssembly.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import EasyDi

class DetailsAssembly: Assembly {
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    
    func viewModel(photoId: String) -> DetailsViewModel {
        return define(init: DetailsViewModelImpl(state: self.servicesAssembly.appState,
                                                 photoId: photoId))
    }
    
    func viewController(viewModel: DetailsViewModel) -> DetailsViewController {
        return define(init: DetailsViewController()) {
            $0.viewModel = viewModel
            return $0
        }
    }
}
