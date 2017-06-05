//
//  MyBillTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class MyBillTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:XFConstants.UI.deviceWidth/5,height:XFConstants.UI.deviceWidth/5)
        layout.scrollDirection = .horizontal
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 10
        //每行之间最小的间距
        layout.minimumLineSpacing = 10
        layout.sectionInset  = UIEdgeInsetsMake(10, 20, 10, 20)
        
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        collectionView.register(FourBillCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    
  
    
    let tipLabelArray = ["待付款","待发货","待收货","待评价"]
    let tipBtnImage = ["myWallet","waitSend","waitReceive","waitComment"]
    func  setUpUI() {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))//将
        })
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
        return 4;
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FourBillCollectionViewCell;
        let row = indexPath.row
        cell.typeDescLabel.text = tipLabelArray[row]
        cell.typeBtn.setImage(UIImage.imageWithNamed(tipBtnImage[row]), for: .normal)
        return cell;
    }
    
        
        
//    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    return (CGSize){cellWidth,cellWidth};
//    }
//    
//    
//    - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//    {
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
