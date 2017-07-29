//
//  MyBillTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let BillCellIdentifier = "XFBillCellIdentifier"
fileprivate let BillCellWidth = XFConstants.UI.deviceWidth / 5

class MyBillTableViewCell: UITableViewCell {

    lazy var tipSourceInfo: Array<Dictionary<String, String>> = {
        return [
            ["title":"待付款","icon":"myWallet"],
            ["title":"待发货","icon":"waitSend"],
            ["title":"待收货","icon":"waitReceive"],
            ["title":"待评价","icon":"waitComment"]
        ]
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 10
        //每行之间最小的间距
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        collectionView.register(FourBillCollectionViewCell.self, forCellWithReuseIdentifier: BillCellIdentifier)
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        self.setUpUI();
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    private func setUpUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
    }
}

extension MyBillTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
        return tipSourceInfo.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCellIdentifier, for: indexPath) as! FourBillCollectionViewCell;
        let source = tipSourceInfo[indexPath.row]
        cell.typeDescLabel.text = source["title"]
        cell.typeBtn.setImage(UIImage.imageWithNamed(source["icon"]!), for: .normal)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BillCellWidth, height: BillCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 20, 0, 20)
    }
}
