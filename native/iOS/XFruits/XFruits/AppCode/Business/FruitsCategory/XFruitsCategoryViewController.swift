//
//  XFruitsCategoryViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

fileprivate let XFCellViewReuseIdentifier:String = "XFCategoryCellReuseIdentifier"

class XFruitsCategoryViewController: XFruitsBaseViewController,
UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {


    lazy var headSizer:XFCategoryHeadSizer = {
        let sizer = XFCategoryHeadSizer(textColor: nil, selectTextColor: nil)
        return sizer;
    }()
    
    lazy var cateListView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let listView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        listView.delegate = self
        listView.dataSource = self
        listView.collectionViewLayout = layout
        listView.backgroundColor = UIColor.white
        listView.register(XFCategoryCell.self, forCellWithReuseIdentifier: XFCellViewReuseIdentifier)
        return listView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("msg-icon"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onAllItemClick))

    
        view.addSubview(headSizer)
        view.addSubview(cateListView)
        
        makeViewConstrains()
    }
    
    fileprivate func makeViewConstrains(){
        headSizer.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view)
        }
        cateListView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headSizer.snp.bottom).offset(10)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-5)
        }
    }

    @objc private func onAllItemClick(){
        let allVC = XFAllCategoryListViewController()
        navigationController?.pushViewController(allVC, animated: true)
    }

    // MARK: - delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFCellViewReuseIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.orange
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 151)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

}
