//
//  GridCell.swift
//  Flickr
//
//  Created by Dmitry Kurach on 12/10/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import UIKit
import Kingfisher

class GridCell: UICollectionViewCell {
    private var token: ObservableToken = 0
    private var viewModel: FlickrPostViewModel?
    private var isFav = false

    func config(viewModel: FlickrPostViewModel, reloadCallback: @escaping () -> Void) {
        self.viewModel = viewModel
        token = viewModel.isFav.observe { [weak self] value in
            guard let self = self, let value = value else { return }
            if self.isFav == value { return }
            
            self.isFav = value
            
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(photo)
        self.contentView.addSubview(favLabel)
        
        photo.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        favLabel.topAnchor.constraint(equalTo: photo.topAnchor).isActive = true
        favLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
