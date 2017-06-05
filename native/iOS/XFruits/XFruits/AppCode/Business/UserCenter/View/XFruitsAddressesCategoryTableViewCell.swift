//
//  XFruitsAddressesCategoryTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/19/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddressesCategoryTableViewCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    
    
    
    lazy var categoryCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width:60,height:60)
         //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 5
        //每行之间最小的间距
        layout.minimumLineSpacing = 5
//        layout.sectionInset  = UIEdgeInsetsMake(10, 20, 10, 20)
//        layout.itemSize = CGSize(width: 10, height: 20)
        let categoryCollectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        categoryCollectionView.dataSource = self;
        categoryCollectionView.delegate = self;
        categoryCollectionView.backgroundColor = UIColor.white
        return categoryCollectionView
    }()
    
    func  setUpUI() {
 
        self.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        })
        
    }

    let categoryArray = ["家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~","家","老婆婆家","丈母娘家","前女友家","前男友家","路人甲家~"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  25
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) ;
        let label = UILabel.init()
        label.text = categoryArray[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 10)

        label.frame =  CGRect(x:0, y:20, width: 20 + widthForLabel(text: label.text! as NSString, font: 10), height:22)
        label.layer.cornerRadius = 10.0
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = XFConstants.Color.salmon

        label.layer.borderColor = XFConstants.Color.salmon.cgColor
        label.layer.borderWidth = 0.5
        cell.contentView.addSubview(label)
        return cell;
    }
    
    func widthForLabel(text:NSString ,font :CGFloat) -> CGFloat {
        let size = text.size(attributes:[NSFontAttributeName:UIFont.systemFont(ofSize: font)])
        return size.width
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        let row = indexPath.row
        let cate  = categoryArray[row]
        return CGSize(width:20 + widthForLabel(text: cate as NSString, font: 10),height:22)
    }

     

}
