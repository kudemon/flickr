//
//  ServicesAssembly.swift
//  Flickr
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import EasyDi

class ServicesAssembly: Assembly {
    var internetClient: InternetClient {
        return define(scope: .lazySingleton,init: FlickrInternetClient())
    }
    
    var appState: AppState {
        return define(init: DictionaryState())
    }
    
    var router: RouterProtocol {
        return define(init: Router())
    }
}
