//
//  NewRequestController+handlers.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/29.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Firebase

extension NewRequestController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    func handleConfirm() {
//        
//        //画像登録
//        let imageName = UUID().uuidString
//        let storageRef = FIRStorage.storage().reference().child("\(imageName).jpg")
//        if let uploadData = UIImagePNGRepresentation(self.requestImageView.image!) {
//            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                //print(metadata!)
//                
//                if let requestImageUrl = metadata?.downloadURL()?.absoluteString {
//                    let ref = FIRDatabase.database().reference().child("requests")
//                    let requestsRef = ref.childByAutoId()
//                    let fromId = FIRAuth.auth()!.currentUser!.uid
//                    let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
//                    let values: [String : Any] = ["title": self.titleTextField.text!, "explanation": self.explanationTextField.text!, "price": self.priceTextField.text!, "fromId": fromId, "timestamp": timestamp, "requestImageView": requestImageUrl]
//                    requestsRef.updateChildValues(values)
//                }
//            })
//        }
//        
//        //registerRequestIntoDatabase()
//        
//        self.dismiss(animated: true, completion: nil)
//    }
    
    private func registerRequestIntoDatabase() {
        
//        
//        let ref = FIRDatabase.database().reference().child("requests")
//        let requestsRef = ref.childByAutoId()
//        let fromId = FIRAuth.auth()!.currentUser!.uid
//        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
//        let values: [String : Any] = ["title": titleTextField.text!, "description": explanationTextField.text!, "price": priceTextField.text!, "fomId": fromId, "timestamp": timestamp, "requestImageView": metadata.downloadUrl()]
//        requestsRef.updateChildValues(values)
    }
    
    
    
//    func handleSelectRequestImageView() {
//        print("imageview tapped")
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//        
//        present(picker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        var selectedImageFromPicker: UIImage?
//        
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            
//            selectedImageFromPicker = originalImage
//        }
//        
//        if let selectedImage = selectedImageFromPicker {
//            requestImageView.image = selectedImage
//        }
//        
//        dismiss(animated: true, completion: nil)
//        
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("canceled picker")
//        dismiss(animated: true, completion: nil)
//    }

    
    
    
}
