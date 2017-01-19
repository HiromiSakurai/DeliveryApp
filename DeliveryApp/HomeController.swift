//
//  HomeController.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/17.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        //setupNav()
//        let statusBar = UIView()
//        statusBar.backgroundColor = UIColor.yellow
//        statusBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(statusBar)
//        navigationController?.view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBar)
//        navigationController?.view.addConstraintsWithFormat(format: "V:|[v0(200)]", views: statusBar)
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 32, green: 32, blue: 230)
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(DeliveryCell.self, forCellWithReuseIdentifier: "cellId")
       
        
        

    }
    
//    let statusBar: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.yellow
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

