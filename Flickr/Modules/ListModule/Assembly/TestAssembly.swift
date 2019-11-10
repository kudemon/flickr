//
//  TestAssembly.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import EasyDi

class ListModuleAssembly: Assembly {
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    
    var flickrModel: FlickrModel {
        return define(scope: .weakSingleton, init: FlickrModelImpl()) {
            $0.internetClient = self.servicesAssembly.internetClient
            $0.appState = self.servicesAssembly.appState
            return $0
        }
    }
    
    var listViewModel: ListViewModel {
        return define(init: ListViewModelImpl(model: self.flickrModel))
    }
    
    var listVC: ListViewController {
        return define(init: ListViewController()) {
            $0.viewModel = self.listViewModel
            $0.router = self.servicesAssembly.router
            return $0
        }
    }
    
    func moduleNavigationController(with viewController: UIViewController) -> UINavigationController {
        return define(init: FlickrNavigationController(rootViewController: viewController))
    }
}
