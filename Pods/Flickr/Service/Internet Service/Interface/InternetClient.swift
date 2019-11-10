//
//  InternetClient.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

typealias InternetClientCompletion = (Result<Data, Error>) -> Void

protocol InternetClient {
    func loadData(ofURL: URL, completion: @escaping InternetClientCompletion)
}
