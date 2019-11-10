//
//  TestModuleCell.swift
//  Flickr
//
//  Created by Герман on 9/13/19.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit
import Kingfisher

class TestModuleCell: UITableViewCell {
    private var token: ObservableToken = 0
    private var viewModel: FlickrPostViewModel?
    private var isFav = false
    
    func config(viewModel: FlickrPostViewModel, reloadCallback: @escaping () -> Void) {
        label.text = viewModel.title
        self.viewModel = viewModel
        token = viewModel.isFav.observe { [weak self] value in
            guard let self = self, let value = value else { return }
            if self.isFav == value { return }
            
            self.isFav = value
            print("\(#function) \(value)")

            if value {
                self.favLabel.attributedText = nil
                self.favLabel.text = "❤️"
            } else {
                let attributes = [NSAttributedString.Key.strokeColor: UIColor.white, NSAttributedString.Key.strokeWidth: -3, NSAttributedString.Key.foregroundColor: UIColor.black] as [NSAttributedString.Key : Any]
                let attributedString = NSAttributedString(string: "♡", attributes: attributes)
                self.favLabel.attributedText = attributedString
            }
        }
        
        photo.kf.setImage(with: viewModel.url) { _ in
            reloadCallback()
        }
    }
    
    override func prepareForReuse() {
        viewModel?.isFav.unobserve(for: token)
    }
    
    private var label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 32)
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var photo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    private var favLabel: UILabel = {
        let lbl = UILabel()
        let attributes = [NSAttributedString.Key.strokeColor: UIColor.white, NSAttributedString.Key.strokeWidth: -3, NSAttributedString.Key.foregroundColor: UIColor.black] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "♡", attributes: attributes)
        lbl.font = UIFont.boldSystemFont(ofSize: 46)
        lbl.attributedText = attributedString
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(photo)
        self.contentView.addSubview(favLabel)
        
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
        photo.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
        photo.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        photo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        favLabel.topAnchor.constraint(equalTo: photo.topAnchor, constant: 8).isActive = true
        favLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
