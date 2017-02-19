//
//  FeedCell.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/23.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var deliveries = [Delivery]()
    
    let cellId = "cellId"
    
    func fetchDeliveries() {
        FIRDatabase.database().reference().child("requests").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let delivery = Delivery()
                //delivery.id = snapshot.key
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                delivery.setValuesForKeys(dictionary)
                delivery.title = dictionary["title"] as? String
                self.deliveries.append(delivery)
                print(delivery)
                print(self.deliveries)
                
                DispatchQueue.main.async(execute: { 
                    self.collectionView.reloadData()
                })
                
                //print(delivery.title, delivery.price)
                
            }
            
//            print("request found")
//            print(snapshot)
        }, withCancel: nil)
    }
    
//    func fetchDeliveries() {
//        ApiService.sharedInstance.fetchDeliveries { (deliveries: [Delivery]) in
//            self.deliveries = deliveries
//            self.collectionView.reloadData()
//        }
//        
//    }

    override func setupViews() {
        super.setupViews()
        
        fetchDeliveries()
        
        backgroundColor = .brown
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(DeliveryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        if let count = deliveries?.count {
        //            return count
        //        }
        return deliveries.count //?? 0 //short cut!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DeliveryCell
        
        cell.delivery = deliveries[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}
