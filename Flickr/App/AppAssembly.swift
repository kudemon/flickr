//
//  AppAssembly.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

//class AppAssembly {
//    private let testModuleAssembly = TestAssembly()
//    private let gridAssembly = GridAssembly()
//    private let dependecyService = DependencyService()
//
//    
//    func assembleApp() -> UIWindow {
//        let window = UIWindow()
//        dependecyService.makeDependencies()
//        
//        let testModuleViewController = testModuleAssembly.rootViewController
//        let gridViewController = gridAssembly.rootViewController
//        
//        
//        
//        let testModuleNavController = FlickrNavigationController(rootViewController: testModuleViewController)
//        let gridNavController = FlickrNavigationController(rootViewController: gridViewController)
//        
//        testModuleNavController.tabBarItem = UITabBarItem(title: "Таблица", image: nil, selectedImage: nil)
//        gridNavController.tabBarItem = UITabBarItem(title: "Коллекция", image: nil, selectedImage: nil)
//        testModuleViewController.title = "Таблица"
//        gridViewController.title = "Коллекция"
//        
//        
//        
//        let tabbarController = UITabBarController()
//        tabbarController.setViewControllers([testModuleNavController, gridNavController], animated: true)
//        
//        window.rootViewController = tabbarController
//        window.makeKeyAndVisible()
//        
//        return window
//    }
//}
