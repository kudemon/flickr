//
//  GridViewController.swift
//  Flickr
//
//  Created by Dmitry Kurach on 06/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    var viewModel: ListViewModel?
    var router: RouterProtocol?
    private var collectionView: UICollectionView!
    private var viewModels: [FlickrPostViewModel] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = UIView()
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel!.state.observe { [weak self] value in
            guard let value = value, let self = self else { return }
            
            switch value {
            case .loaded(let viewModels):
                self.viewModels = viewModels
                self.collectionView.reloadData()
            case .error(let error):
                let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        viewModel!.flickr()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white

        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        collectionCell.config(viewModel: viewModels[indexPath.item]) {
        }
        return collectionCell
    }
}

extension GridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModels[indexPath.row]
        router!.goToDetails(id: photo.id, controller: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



