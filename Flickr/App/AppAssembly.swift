//
//  AppAssembly.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import EasyDi

class AppAssembly: Assembly {
    private lazy var listModuleAssembly: ListModuleAssembly = context.assembly()
    private lazy var gridModuleAssembly: GridAssembly = context.assembly()
    
    func assemble() -> UIWindow {
        let window = UIWindow()
        
        let listViewController = listModuleAssembly.listVC
        let gridViewController = gridModuleAssembly.gridModuleVC
        
        let listNavController = listModuleAssembly.moduleNavigationController(with: listViewController)
        let gridNavController = gridModuleAssembly.moduleNavigationController(with: gridViewController)
        
        listNavController.tabBarItem = UITabBarItem(title: "Таблица", image: nil, selectedImage: nil)
        gridNavController.tabBarItem = UITabBarItem(title: "Коллекция", image: nil, selectedImage: nil)
        listNavController.title = "Таблица"
        gridNavController.title = "Коллекция"
        
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers([listNavController, gridNavController], animated: true)

        window.rootViewController = tabbarController
        window.makeKeyAndVisible()

        return window
    }
}
