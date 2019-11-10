//
//  Router.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class Router: RouterProtocol {
    private lazy var detailsAssembly = DetailsAssembly.instance()
    
    func goToDetails(id: String, controller: UIViewController) {
        
        
        let vm = detailsAssembly.viewModel(photoId: id)
        let vc = detailsAssembly.viewController(viewModel: vm)
        
        vc.hidesBottomBarWhenPushed = true
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
