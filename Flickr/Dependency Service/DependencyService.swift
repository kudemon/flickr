//
//  DependencyService.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit
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

class ModelsAssembly: Assembly {
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    
    var testModuleModel: TestModuleModel {
        return define(init: FlickrModel()) {
            $0.internetClient = self.servicesAssembly.internetClient
            $0.appState = self.servicesAssembly.appState
            return $0
        }
    }
}

class ViewModelsAssembly: Assembly {
    private lazy var modelsAssembly: ModelsAssembly = context.assembly()
    
    var testModuleViewModel: TestModuleViewModel {
        return define(init: ГолосуйИлиПроиграешьViewModel(model: self.modelsAssembly.testModuleModel))
    }
}

class ViewAssembly: Assembly {
    private lazy var vmsAssembly: ViewModelsAssembly = context.assembly()
    private lazy var serviceAssembly: ServicesAssembly = context.assembly()
    
    var testModuleVC: TestModuleViewController {
        return define(init: TestModuleViewController()) {
            $0.viewModel = self.vmsAssembly.testModuleViewModel
            $0.router = self.serviceAssembly.router
            return $0
        }
    }
    
    var gridModuleVC: GridViewController {
       return define(init: GridViewController()) {
            $0.viewModel = self.vmsAssembly.testModuleViewModel
            $0.router = self.serviceAssembly.router
            return $0
        }
    }
}



//class DependencyService {
//    func makeDependencies() {
//        DIFramework.shared.register {
//            FlickrInternetClient() as InternetClient
//        }
//
//        DIFramework.shared.register {
//            DictionaryState.shared as AppState
//        }
//
//        DIFramework.shared.register { () -> TestModuleModel in
//            var appState: AppState = resolve()
//            let model = FlickrModel(internetClient: resolve(), appState: appState)
//            appState.callbacks.append(model)
//            return model as TestModuleModel
//        }
//
//        DIFramework.shared.register {
//            ГолосуйИлиПроиграешьViewModel(model: resolve()) as TestModuleViewModel
//        }
//
//        DIFramework.shared.register {
//            Router() as RouterProtocol
//        }
//
//        DIFramework.shared.register {
//            TestModuleViewController(viewModel: resolve(), router: resolve())
//        }
//
//        DIFramework.shared.register {
//            GridViewController(viewModel: resolve(), router: resolve())
//        }
//
//        DIFramework.shared.register {
//            DetailsViewController(viewModel: resolve(), router: resolve())
//        }
//    }
//}
