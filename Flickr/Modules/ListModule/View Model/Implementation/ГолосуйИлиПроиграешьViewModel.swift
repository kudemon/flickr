//
//  ГолосуйИлиПроиграешьViewModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class ListViewModelImpl: ListViewModel {
    let state = Observable<ListViewModelState>()
    
    private let model: FlickrModel
    private var viewModels = [FlickrPostViewModelImpl]()
    
    init(model: FlickrModel) {
        self.model = model
        
        model.state.onChanged = { [weak self] value in
            guard let value = value, let self = self else { return }
            
            switch value {
            case .loaded(let photos):
                self.viewModels = photos.compactMap { (photo: Photo) -> FlickrPostViewModelImpl? in
                    let viewModel = FlickrPostViewModelImpl(photo: photo)
                    viewModel?.isFav.observe { [weak viewModel, weak self] newValue in
                        guard let self = self, let viewModel = viewModel, let newValue = newValue else { return }
                        
                        print("\(#function) \(newValue)")
                        self.model.like(id: viewModel.id, liked: newValue)
                    }
                    return viewModel
                }
                
                self.state.value = .loaded(self.viewModels)
            case .error(let error):
                self.state.value = .error(error)
            case .changed(let photo, let isFav):
                print("\(#function) \(isFav)")
                (self.viewModels.first { $0.id == photo.id })?.isFav.value = isFav
            }
        }
    }
    
    func flickr() {
        model.loadFlickr()
    }
}
