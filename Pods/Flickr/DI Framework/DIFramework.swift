//
//  DIFramework.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class DIFramework {
    static let shared = DIFramework()
    
    private var factoriesDictionary = [ObjectIdentifier: Any]()
    
    func register<T>(factory: @escaping () -> T) {
        let objectIdentifier = ObjectIdentifier(T.self)
        factoriesDictionary[objectIdentifier] = factory
    }
    
    func resolve<T>() -> T {
        let objectIdentifier = ObjectIdentifier(T.self)
        return (factoriesDictionary[objectIdentifier] as! () -> T)()
    }
}

func resolve<T>() -> T {
    return DIFramework.shared.resolve()
}
