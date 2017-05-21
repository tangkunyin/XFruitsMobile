
//
//  XFCategoryCell.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class XFCategoryCell: UICollectionViewCell {
 
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("sampleGoodsInCategoryCell"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = grayColor(102)
        title.font = XFConstants.Font.mainBodyFont
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var priceLabel:UILabel = {
        let price = UILabel()
        price.textColor = XFConstants.Color.salmon
        price.font = XFConstants.Font.mainBodyFont
        price.textAlignment = .left
        price.adjustsFontSizeToFitWidth = false
        price.lineBreakMode = .byTruncatingTail
        return price
    }()
    
    
    lazy var cartBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.imageWithNamed("shopcart-hilight"), for: .normal)
        return btn
    }()
    

    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleLabel.text = "拾个苹果圣诞果一箱6个"
        priceLabel.text = "¥ 36"
        
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(cartBtn)
        
        makeCellConstrains()
        
    }
    
    //    convenience init(goodsInfo:XFruitsGoodsInfo?){
    //        self.init()
    //
    //        titleLabel.text = "拾个苹果圣诞果一箱6个"
    //        priceLabel.text = "¥ 36"
    //
    //        addSubview(thumbnail)
    //        addSubview(titleLabel)
    //        addSubview(priceLabel)
    //        addSubview(cartBtn)
    //
    //        makeCellConstrains()
    //        
    //        print("走了没走")
    //    }
    
    private func makeCellConstrains(){
        thumbnail.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp.top)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.thumbnail.snp.bottom)
            make.height.equalTo(35)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.priceLabel.snp.top)
            make.bottom.equalTo(self.cartBtn.snp.top)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(30)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self.cartBtn.snp.left)
            make.bottom.equalTo(self).offset(10)
        }
        cartBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.size.equalTo(30)
            make.left.equalTo(self.priceLabel.snp.right)
            make.right.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
