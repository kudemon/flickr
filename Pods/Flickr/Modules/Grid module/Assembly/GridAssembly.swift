//
//  GridAssembly.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class GridAssembly: ModuleAssembly {
    var rootViewController: UIViewController {
        let gridViewController: GridViewController = resolve()
        return gridViewController
    }
}
