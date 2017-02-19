//
//  Extensions.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/19.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import Foundation
import UIKit

//クラスの中に書くとエラー
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false  //ここで毎回autolayout解除!
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

class statusBar :UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



let imageCache = NSCache<NSString, UIImage>()


class CustumImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if error != nil {
                //print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
            
                if self.imageUrlString == urlString {
                self.image = imageToCache
                }
            
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            
            })
            
            
        }).resume()
    }

}






























