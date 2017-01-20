//
//  MenuBar.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/19.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    
    let statusNames = ["注文中", "配達中", "配達済"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //最初に「注文中」を選択する
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.statusView.text = statusNames[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuCell: BaseCell {
    
    let statusView: UILabel = {
        let label = UILabel()
        label.text = "注文中"
        label.font = label.font.withSize(25)
        label.textColor = UIColor.gray
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            statusView.textColor = isHighlighted ? UIColor.red : UIColor.gray
        }
    }
    override var isSelected: Bool {
        didSet {
            statusView.textColor = isSelected ? UIColor.red : UIColor.gray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.yellow
        addSubview(statusView)
        addConstraintsWithFormat(format: "H:[v0(90)]", views: statusView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: statusView)
        addConstraint(NSLayoutConstraint(item: statusView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: statusView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}


















