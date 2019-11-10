//
//  FlickrNavigationController.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class  FlickrNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        styleNavBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        styleNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleNavBar()
    }
}

extension FlickrNavigationController {
    private func styleNavBar() {
        navigationBar.backgroundColor = UIColor.blue
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.blue
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 17)
        ]
    }
}

