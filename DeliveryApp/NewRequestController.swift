//
//  NewRequestController.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/26.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Firebase
import Eureka
import ImageRow

class NewRequestController: FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "注文情報"
        navigationController?.navigationBar.isTranslucent = false
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 128, height: view.frame.height))
        title.textAlignment = .center
        title.text = "注文入力"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        //navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        UINavigationBar.appearance().backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        //Start Eureka Setup
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        }
        
        form +++ Section()
            <<< ImageRow("imageRow"){ row in
                row.title = "画像登録"
                }.cellSetup { cell, row in
                    row.cell.height = {100}
        }
        
        +++ Section("概要")
            <<< TextRow("textRow"){ row in
                row.placeholder = "タイトル入力"
        }
            <<< TextAreaRow("textAreaRow"){
                $0.placeholder = "詳細を入力"
        }
            
        +++ Section("金額")
            <<< IntRow("intRow"){
                $0.title = "¥"
                $0.placeholder = "金額入力"
            }
            
        
        +++ Section("期限")
            <<< DateTimeRow("dateTimeRow"){
                $0.value = Date(timeIntervalSinceNow: 0)
        }
        
        +++ Section()
            <<< ButtonRow("buttonRow"){
                $0.title = "注文"
                }.onCellSelection { cell, row in
                    let textRow: TextRow? = self.form.rowBy(tag: "textRow")
                    let textRowValue = textRow?.value
                    
                    let textAreaRow: TextAreaRow? = self.form.rowBy(tag: "textAreaRow")
                    let textAreaRowValue = (textAreaRow?.value)! as String
                    
                    let dateTimeRow: DateTimeRow? = self.form.rowBy(tag: "dateTimeRow")
                    let dateTimeRowValue = dateTimeRow?.value
                    
                    
                    let intRow: IntRow? = self.form.rowBy(tag: "intRow")
                    let intRowValue = intRow?.value
                    
                    let imageRow: ImageRow? = self.form.rowBy(tag: "imageRow")
                    let imageRowValue = imageRow?.value
                    
                    //画像登録
                    let imageName = UUID().uuidString
                    let storageRef = FIRStorage.storage().reference().child("\(imageName).jpg")
                    if let uploadData = UIImagePNGRepresentation(imageRowValue!) {
                        storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            //print(metadata!)
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm"
                            let stringDate: String = formatter.string(from: dateTimeRowValue!)
                            print(stringDate)
                            let intToString: String = (intRowValue?.description)!
                    
                            if let requestImageUrl = metadata?.downloadURL()?.absoluteString {
                                let ref = FIRDatabase.database().reference().child("requests")
                                let requestsRef = ref.childByAutoId()
                                let fromId = FIRAuth.auth()!.currentUser!.uid
                                let timestamp: String = formatter.string(from: NSDate() as Date)
                                let values: [String : Any] = ["title": textRowValue!, "explanation": textAreaRowValue, "price": intToString, "fromId": fromId, "timestamp": timestamp, "timeLimit": stringDate, "requestImageView": requestImageUrl]
                                        requestsRef.updateChildValues(values)
                            }
                        })
                    }
                            
                    //registerRequestIntoDatabase()
                            
                    self.dismiss(animated: true, completion: nil)
                }
        
            
        
        
        
//        view.addSubview(requestImageView)
//        view.addSubview(containerView)
//        view.addSubview(confirmButton)
//        
//        setupRequestImageView()
//        setupContainerView()
//        setupConfirmButton()
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    
//    func commitButtonTapped (){
//        self.view.endEditing(true)
//    }
    
    
    
//    func setupRequestImageView() {
//        requestImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        requestImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -12).isActive = true
//        requestImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        requestImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//    }
    
    //    let containerView: UIView = {
    //       let view = UIView()
    //        view.backgroundColor = UIColor.white
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        view.layer.cornerRadius = 5
    //        view.layer.masksToBounds = true
    //        return view
    //    }()
    //
    //    let titleTextField: UITextField = {
    //        let tf = UITextField()
    //        tf.placeholder = "Title"
    //        tf.translatesAutoresizingMaskIntoConstraints = false
    //        return tf
    //    }()
    //
    //    let titleSeparatorView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let explanationTextField: UITextView = {
    //        let tf = UITextView()
    //        tf.textAlignment = .left
    //        tf.font = UIFont.systemFont(ofSize: 15)
    //        tf.translatesAutoresizingMaskIntoConstraints = false
    //        return tf
    //    }()
    //
    //    let explanationSeparatorView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    let priceTextField: UITextField = {
    //        let tf = UITextField()
    //        tf.placeholder = "Price"
    //        tf.translatesAutoresizingMaskIntoConstraints = false
    //        return tf
    //    }()
    //
    //    let confirmButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
    //        button.setTitle("注文確定", for: UIControlState())
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.setTitleColor(.white, for: UIControlState())
    //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //        button.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
    //        return button
    //    }()
    //
    //    lazy var requestImageView: UIImageView = {
    //       let imageView = UIImageView()
    //        imageView.image = UIImage(named: "camera_icon")
    //        imageView.backgroundColor = UIColor.white
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        imageView.contentMode = .scaleAspectFill
    //        
    //        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectRequestImageView)))
    //        imageView.isUserInteractionEnabled = true
    //        return imageView
    //    }()

    
    
//    func setupContainerView() {
//        
//        containerView.addSubview(titleTextField)
//        containerView.addSubview(titleSeparatorView)
//        containerView.addSubview(explanationTextField)
//        containerView.addSubview(explanationSeparatorView)
//        containerView.addSubview(priceTextField)
//        
//        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
//        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        
//        titleTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
//        titleTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        titleTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        titleTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/8).isActive = true
//        
//        titleSeparatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//        titleSeparatorView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor).isActive = true
//        titleSeparatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        titleSeparatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        
//        explanationTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
//        explanationTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor).isActive = true
//        explanationTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        explanationTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 6/8).isActive = true
//        
//        explanationSeparatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//        explanationSeparatorView.topAnchor.constraint(equalTo: explanationTextField.bottomAnchor).isActive = true
//        explanationSeparatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        explanationSeparatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        
//        priceTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
//        priceTextField.topAnchor.constraint(equalTo: explanationTextField.bottomAnchor).isActive = true
//        priceTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
//        priceTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/8).isActive = true
//    }
//    
//    func setupConfirmButton() {
//        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        confirmButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12).isActive = true
//        confirmButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/3).isActive = true
//        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}



