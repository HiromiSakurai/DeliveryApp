//
//  ApiService.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/22.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Firebase

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    

    
//    func fetchDeliveries(_ completion: @escaping ([Delivery]) -> ()) {
//        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//            if error != nil {
//                //print(error)
//                return
//            }
//            
//            do {
//                // jsonの形にperse
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                //print(json)
//                
//                var deliveries = [Delivery]()
//                
//                for dictionary in json as! [[String: Any]] {
//                    let delivery = Delivery()
//                    delivery.title = dictionary["title"] as? String
//                    delivery.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    //print(delivery.title)
//                    //print(delivery.thumbnailImageName)
//                    deliveries.append(delivery)
//                }
//                
//                DispatchQueue.main.async(execute: {
//                    completion(deliveries)
//                })
//                
//                
//            } catch let jsonError {
//                print(jsonError)
//            }
//            
//        }) .resume()
//    }
    
    func fetchDeliveringFeed(_ completion: @escaping ([Delivery]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                //print(error)
                return
            }
            
            do {
                // jsonの形にperse
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //print(json)
                
                var deliveries = [Delivery]()
                
                for dictionary in json as! [[String: Any]] {
                    let delivery = Delivery()
                    delivery.title = dictionary["title"] as? String
                    delivery.requestImageView = dictionary["thumbnail_image_name"] as? String
                    //print(delivery.title)
                    //print(delivery.thumbnailImageName)
                    deliveries.append(delivery)
                }
                
                DispatchQueue.main.async(execute: {
                    completion(deliveries)
                })
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }) .resume()
    }
    
    func fetchDeliveredFeed(_ completion: @escaping ([Delivery]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                //print(error)
                return
            }
            
            do {
                // jsonの形にperse
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //print(json)
                
                var deliveries = [Delivery]()
                
                for dictionary in json as! [[String: Any]] {
                    let delivery = Delivery()
                    delivery.title = dictionary["title"] as? String
                    delivery.requestImageView = dictionary["thumbnail_image_name"] as? String
                    //print(delivery.title)
                    //print(delivery.thumbnailImageName)
                    deliveries.append(delivery)
                }
                
                DispatchQueue.main.async(execute: {
                    completion(deliveries)
                })
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }) .resume()
    }
}
