//
//  DetailsViewController.swift
//  Flickr
//
//  Created by Герман on 9/15/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModel?
    var id: String?
    var likeButton: UIButton?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        title = viewModel?.title
        view = UIView()
        view.backgroundColor = UIColor.white
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView() {
        func defaultLabel(_ previous: UILabel?) -> UILabel {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.boldSystemFont(ofSize: 20)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }
        
        let title = defaultLabel(nil)
        let id = defaultLabel(title)
        let owner = defaultLabel(id)
        let isPublic = defaultLabel(owner)
        let isFriend = defaultLabel(isPublic)
        let isFamily = defaultLabel(isFriend)
        
        title.text = "Title: \(self.viewModel!.title)"
        id.text = "ID: \(self.viewModel!.id)"
        owner.text = "Owner: \(self.viewModel!.owner)"
        isPublic.text = "Is Public: \(String(self.viewModel!.ispublic))"
        isFriend.text = "Is Friend: \(String(self.viewModel!.isfriend))"
        isFamily.text = "Is Family: \(String(self.viewModel!.isfamily))"
        
        
        let photo: UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFit
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            return img
        }()
        
        let back: UIButton = {
            let btn = UIButton()
            btn.setTitle("Назад", for: .normal)
            btn.setTitleColor(.blue, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        let like: UIButton = {
            let btn = UIButton()
            if self.viewModel!.isFav {
                btn.setTitle("❤️ Лайк", for: .normal)
            } else {
                btn.setTitle("♡ Лайк", for: .normal)
            }
            btn.setTitleColor(.blue, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        likeButton = like
        
        photo.kf.setImage(with: viewModel?.url)
        
        view.addSubview(title)
        view.addSubview(id)
        view.addSubview(owner)
        view.addSubview(isPublic)
        view.addSubview(isFriend)
        view.addSubview(isFamily)
        view.addSubview(photo)
        view.addSubview(back)
        view.addSubview(like)
        
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        like.addTarget(self, action: #selector(doLike), for: .touchUpInside)
        
        
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        title.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 32).isActive = true
        
        id.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        id.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        id.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        
        owner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        owner.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        owner.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 16).isActive = true
        
        isPublic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        isPublic.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        isPublic.topAnchor.constraint(equalTo: owner.bottomAnchor, constant: 16).isActive = true
        
        isFriend.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        isFriend.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        isFriend.topAnchor.constraint(equalTo: isPublic.bottomAnchor, constant: 16).isActive = true
        
        isFamily.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        isFamily.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        isFamily.topAnchor.constraint(equalTo: isFriend.bottomAnchor, constant: 16).isActive = true
        
        photo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        photo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        photo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        back.topAnchor.constraint(equalTo: isFamily.bottomAnchor, constant: 32).isActive = true
        back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        like.topAnchor.constraint(equalTo: isFamily.bottomAnchor, constant: 32).isActive = true
        like.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    @objc func doLike() {
        if viewModel!.isFav {
            likeButton?.setTitle("♡ Лайк", for: .normal)
        } else {
            likeButton?.setTitle("❤️ Лайк", for: .normal)
        }
    }
}
