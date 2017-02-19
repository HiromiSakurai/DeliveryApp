//
//  DeliveredCell.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/23.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit

class DeliveredCell: FeedCell {

    override func fetchDeliveries() {
        ApiService.sharedInstance.fetchDeliveredFeed { (deliveries: [Delivery]) in
            self.deliveries = deliveries
            self.collectionView.reloadData()
        }
    }
}
