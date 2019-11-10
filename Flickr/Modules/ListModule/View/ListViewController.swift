//
//  TestModuleViewController.swift
//  Flickr
//
//  Created by Krasa on 08/09/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var viewModel: ListViewModel?
    var router: RouterProtocol?
    
    private let tableView = UITableView()
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
        view.backgroundColor = UIColor.white
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel!.state.observe { [weak self] value in
            guard let value = value, let self = self else { return }
            
            switch value {
            case .loaded(let viewModels):
                self.viewModels = viewModels
                self.tableView.reloadData()
            case .error(let error):
                let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        viewModel!.flickr()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(TestModuleCell.self, forCellReuseIdentifier: "cell")
        
        
    }
}


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TestModuleCell
        cell.config(viewModel: viewModels[indexPath.item]) {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModels[indexPath.row]
        // TODO: пробросить в роутер айдишник этой фотки. Роутер = зависимость контролера такая же, как и вью модель. gotoPhotosDetails( id: String )
        router!.goToDetails(id: photo.id, controller: self)
    }
}
