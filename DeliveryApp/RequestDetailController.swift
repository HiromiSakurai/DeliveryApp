//
//  RequestDetailController.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/02/21.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Eureka

class RequestDetailController: FormViewController {
    var delivery: Delivery!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = self.delivery.title
        navigationItem.title = "詳細画面"
        navigationController?.navigationBar.isTranslucent = false
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 128, height: view.frame.height))
        title.textAlignment = .center
        title.text = "注文詳細"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        
        formSet()
    }
    
    func formSet() {
        
//        ImageRow.defaultCellUpdate = { cell, row in
//            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 90 , height: 90)
//        }
        
        form
            +++ Section("Section1") { section in
                var header = HeaderFooterView<CustumImageView>(.class)
                
                header.height = {200}
                header.onSetupView = { view, section in
                    view.backgroundColor = UIColor.orange
                    //view.image = UIImage(named: "icon")
                    view.contentMode = .scaleAspectFill
                    view.clipsToBounds = true
                    if let requestImageViewUrl = self.delivery?.requestImageView {
                        view.loadImageUsingUrlString(urlString: requestImageViewUrl)
                        
                    }
                    //view.isUserInteractionEnabled = true
//                    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSelectorFooterImage)))
                }
                section.header = header
            }
            
            <<< TextRow(){ row in
                //row.title = "要件"
                row.value = delivery.title
                //row.placeholder = "enter text here"
            }
            
            <<< TextAreaRow(){
                //$0.title = "TextArea"
                $0.value = delivery.explanation
            }
            
            +++ Section("金額")
            <<< IntRow(){
                let strVal: String! = delivery.price
                if let intVal: Int = Int(strVal) {
                    $0.title = "¥"
                    $0.value = intVal
                    //$0.placeholder = "and numbers here"
                }
                
            }
            
            +++ Section("期限")
            <<< DateTimeRow("dateTimeRow"){
                //$0.title = "DateTime"
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                let timeString = delivery.timeLimit
                let timeDate = formatter.date(from: timeString!)
                $0.value = timeDate
                
            }
        
            
            
            
//            +++ Section()
//            <<< ImageRow("imageRow"){ row in
//                row.title = "ImageRow"
//                }.cellSetup { cell, row in
//                    row.cell.height = {100}
//        }
        
        
    }




}






