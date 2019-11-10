//
//  DetailsViewModel.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

protocol DetailsViewModel: class {
    var url: URL? { get }
    var id: String { get }
    var owner: String { get }
    var ispublic: Int { get }
    var isfriend: Int { get }
    var isfamily: Int { get }
    var title: String { get }
    var isFav: Bool { get set }
    var favButtonTitle: Observable<String> { get }
}

typealias ObservableToken = Int

class Observable<T> {
    var value: T? {
        didSet {
            observables.values.forEach { element in
                DispatchQueue.main.async {
                    element(self.value)
                }
            }
            
            DispatchQueue.main.async {
                self.onChanged?(self.value)
            }
        }
    }
    private var observables = [ObservableToken: (T?) -> Void]()
    var onChanged: ((T?) -> Void)?
    
    @discardableResult
    func observe(closure: @escaping (T?) -> Void) -> ObservableToken {
        let token = ObservableToken.random(in: 0...1000_000_000_000)
        observables[token] = closure
        return token
    }
    
    func unobserve(for key: ObservableToken) {
        observables.removeValue(forKey: key)
    }
}
