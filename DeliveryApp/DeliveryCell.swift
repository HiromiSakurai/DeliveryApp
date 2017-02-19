//
//  DeliveryCell.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/19.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class DeliveryCell: BaseCell {
    
    var delivery: Delivery? {
        didSet {
            titleLabel.text = delivery?.title
            priceLabel.text = delivery?.price
            
            setupThumbnailImage()
            
        }
    }
    

    
    func setupThumbnailImage() {
        if let requestImageViewUrl = delivery?.requestImageView {
            thumbnailImageView.loadImageUsingUrlString(urlString: requestImageViewUrl)
        }
    }
    
    
    let thumbnailImageView: CustumImageView = {
        let imageView = CustumImageView()
        imageView.backgroundColor = UIColor.blue
        //imageView.image = UIImage(named: "myImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        //label.text = "至急！　お水ください！"
        return label
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.backgroundColor = UIColor.green
        price.text = "¥500"
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-3-[v0]-20-[v1(250)]-3-|", views: thumbnailImageView, titleLabel)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-3-[v0]-3-[v1(1)]|", views: thumbnailImageView, separatorView)
        addConstraintsWithFormat(format: "V:|-3-[v0(60)]", views: titleLabel)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        //left
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        //right
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //bottom
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 0))
        
        
    }

}

    
