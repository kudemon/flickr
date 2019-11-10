//
//  Router.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class Router: RouterProtocol {
    func goToDetails(id: String, controller: UIViewController) {
        let newViewController = DetailsAssembly(id: id).rootViewController
        newViewController.hidesBottomBarWhenPushed = true
        controller.navigationController?.pushViewController(newViewController, animated: true)
    }
}
