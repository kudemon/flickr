//
//  GridAssembly.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import EasyDi

class GridAssembly: Assembly {
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    private lazy var listModuleAssembly: ListModuleAssembly = context.assembly()

    var testModuleViewModel: ListViewModel {
        return define(init: ListViewModelImpl(model: self.listModuleAssembly.flickrModel))
    }

    var gridModuleVC: UIViewController {
       return define(init: GridViewController()) {
            $0.viewModel = self.testModuleViewModel
            $0.router = self.servicesAssembly.router
            return $0
        }
    }
    
    func moduleNavigationController(with viewController: UIViewController) -> UINavigationController {
        return define(init: FlickrNavigationController(rootViewController: viewController))
    }
}
