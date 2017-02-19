//
//  HomeController.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/17.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var deliveries: [Delivery] = {
//        var request = Delivery()
//        request.title = "kkkkkanu"
//        request.thumbnailImageName = "myImage"
//        
//        var request2 = Delivery()
//        request2.title = "panipn"
//        request2.thumbnailImageName = "myImage2"
//        
//        return [request, request2]
//    }()
    
    
    
    let cellId = "cellId"
    let deliveringCellId = "deliveringCellId"
    let deliveredCellId = "deliveredCellId"
    
    let floatButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("注文", for: UIControlState())
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //user is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        
        //navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
//        titleLabel.text = "Home"
//        titleLabel.textColor = UIColor.white
//        titleLabel.font = UIFont.systemFont(ofSize: 20)
//        navigationItem.titleView = titleLabel
        
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarBottons()
        
        
        setupFloatButton()
    }
    
    func setupFloatButton() {
        view.addSubview(floatButton)
        
        floatButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        floatButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        floatButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        floatButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    func buttonClick() {
        let newRequestController = NewRequestController()
//        newRequestController.view.backgroundColor = UIColor.lightGray
//        newRequestController.navigationItem.title = "注文する"
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.pushViewController(newRequestController, animated: true)
        let navController = UINavigationController(rootViewController: newRequestController)
        print("float button clicked")
        present(navController, animated: true, completion: nil)
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        print("user logout.....")
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        
        collectionView?.backgroundColor = UIColor.white
        //collectionView?.register(DeliveryCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(DeliveringCell.self, forCellWithReuseIdentifier: deliveringCellId)
        collectionView?.register(DeliveredCell.self, forCellWithReuseIdentifier: deliveredCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
        collectionView?.isScrollEnabled = false
    }
    
    func setupNavBarBottons() {
        let listImage = UIImage(named: "list_icon")
        let listBarBottonItem = UIBarButtonItem(image: listImage, style: .plain, target: self, action: #selector(handleList))
        navigationItem.rightBarButtonItem = listBarBottonItem
    }
    
    let settingsLauncher = SettingsLauncher()
    
    func handleList() {
        print("touched list icon")
        settingsLauncher.showSettings() //show slide menu
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: deliveringCellId, for: indexPath)
        } else if indexPath.item == 2 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: deliveredCellId, for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

