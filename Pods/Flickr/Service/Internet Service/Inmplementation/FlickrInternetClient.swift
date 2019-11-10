//
//  FlickrInternetClient.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class FlickrInternetClient: InternetClient {    
    func loadData(ofURL: URL, completion: @escaping InternetClientCompletion) {
        let task = URLSession.shared.dataTask(with: ofURL) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
