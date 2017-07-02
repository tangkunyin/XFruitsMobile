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
    
    var dataSource:[ProductItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("msg-icon"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onAllItemClick))
        
        
        view.addSubview(headSizer)
        view.addSubview(cateListView)
        
        makeViewConstrains()
        
        weak var weakSelf = self
        let params:XFParams = ["fruit":1000,"sort":101,"sequence":1,"page":1,"size":6]
        XFCommonService().getAllProducts(params: params) { (data) in
            if let cateList = data as? CategoryList, let dataSource = cateList.content {
                weakSelf?.dataSource = dataSource
                weakSelf?.cateListView.reloadData()
            }
        }
        
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
        let allVC = XFAllCategoryListViewController()
        navigationController?.pushViewController(allVC, animated: true)
    }
    
    // MARK: - delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFCellViewReuseIdentifier, for: indexPath)
        guard let cateCell:XFCategoryCell = cell as? XFCategoryCell  else {
            return cell
        }
        cateCell.dataSource = dataSource[indexPath.row]
        return cateCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-30)/2, height: 226)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = XFDetailViewController()
        let item:ProductItem = dataSource[indexPath.row]
        detail.prodId = item.id
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
