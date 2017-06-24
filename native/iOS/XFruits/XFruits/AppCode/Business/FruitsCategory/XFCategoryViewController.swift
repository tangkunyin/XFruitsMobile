//
//  XFCategoryViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit


fileprivate let XFCellViewReuseIdentifier:String = "XFCategoryCellReuseIdentifier"

class XFCategoryViewController: XFBaseViewController,
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
            make.height.equalTo(30)
            make.left.right.equalTo(self.view)
        }
        cateListView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headSizer.snp.bottom).offset(0)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    
    @objc private func onAllItemClick(){
        //        let allVC = XFAllCategoryListViewController()
        //        navigationController?.pushViewController(allVC, animated: true)
        
        let params:XFParams = ["userId":"","fruit":1000,"order":101,"sequence":1,"page":0,"pageSize":6]
        XFCommonService().getAllProducts(params: params) { (data) in
            dPrint(data)
        }
    }
    
    // MARK: - delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFCellViewReuseIdentifier, for: indexPath)
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-30)/2, height: 226)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = XFDetailViewController()
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
}

