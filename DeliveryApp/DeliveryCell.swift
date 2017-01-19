//
//  DeliveryCell.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/19.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit


class DeliveryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "myImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.text = "至急！　お水ください！"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        //price.backgroundColor = UIColor.green
        price.text = "¥500"
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        
        addConstraintsWithFormat(format: "H:|-5-[v0]-20-[v1(250)]-5-|", views: thumbnailImageView, titleLabel)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-5-[v0]-4-[v1(1)]|", views: thumbnailImageView, separatorView)
        
        addConstraintsWithFormat(format: "V:|-5-[v0(60)]", views: titleLabel)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        //left
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        //right
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //bottom
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .bottom, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 0))
        
        
        
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView, "v1": separatorView]))
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    
