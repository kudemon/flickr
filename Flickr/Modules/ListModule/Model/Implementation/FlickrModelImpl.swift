//
//  FlockrModel.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class FlickrModelImpl {
    var internetClient: InternetClient?
    var appState: AppState?
    private var callback: ListViewModel?
    private var internalState = Observable<FlickrModelState>()
}

extension FlickrModelImpl: FlickrModel {
    func like(id: String, liked: Bool) {
        appState!.updatePhoto(id: id, isFav: liked)
    }
    
    var state: Observable<FlickrModelState> {
        return internalState
    }
    
    
    func loadFlickr() {
        let urlString = "https://www.flickr.com/services/rest?method=flickr.interestingness.getList&api_key=3988023e15f45c8d4ef5590261b1dc53&per_page=12&page=1&format=json&nojsoncallback=1#photos/photo/5"
        let url = URL(string: urlString)!
        internetClient?.loadData(ofURL: url) { flickrResponse in
            switch flickrResponse {
            case .success(let data):
                do {
                    let flickrResponse = try JSONDecoder().decode(FlickrResponse.self, from: data)
                    flickrResponse.photos.photo.forEach { self.appState!.set(photo: $0) }
                    self.internalState.value = .loaded(flickrResponse.photos.photo)
                } catch {
                    print("ERROR \(error)")
                    self.internalState.value = .error(error)
                }
            case .failure(let error):
                self.internalState.value = .error(error)
                print("ERROR \(error)")
            }
        }
    }
}

extension FlickrModelImpl: AppStateCallbacks {
    func photoDidChange(_ photo: Photo, isFav: Bool) {
        print("\(#function) \(isFav)")
        self.internalState.value = .changed(photo, isFav)
    }
}

/*
 1. Протокол Router. Он принимает на вход id фотки
 2. Модуль деталей фотки - просмотр фулскрин с информацией о названии фотки, ее авторе и кнопкой "лайк". состояние кнопки зависит от того, лайкнули ль ее в AppState
 3. Доделать подписку на изменение состояния модели тут ( вверху), передать событие во вьюмодель, вьюмодель передаеьт событие на вью, вьюха перезагружает таблицу - звездочка - признак того, лайкнули или нет фотку
 
 
 
 
*/
