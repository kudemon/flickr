//
//  TestAssembly.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class TestAssembly: ModuleAssembly {
    var rootViewController: UIViewController {
        let testModuleViewController: TestModuleViewController = resolve()
        return testModuleViewController
    }
}
