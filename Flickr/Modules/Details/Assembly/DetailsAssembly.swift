//
//  DetailsAssembly.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class DetailsAssembly: ModuleAssembly {
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var rootViewController: UIViewController {
        let viewController: DetailsViewController = resolve()
        viewController.id = self.id
        return viewController
    }
}
