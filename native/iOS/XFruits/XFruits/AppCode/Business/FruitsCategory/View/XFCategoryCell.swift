
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
import MBProgressHUD

public let XFCategoryCellWidth = (XFConstants.UI.deviceWidth - 30) / 2


class XFCategoryCell: UICollectionViewCell {
 
    private var imgViewHeightConstraint: Constraint?
    
    var dataSource:ProductItem? {
        didSet {
            if let item = dataSource {
                titleLabel.text = item.name
                priceLabel.text = String(format:"%.2f",item.salesPrice)
                thumbnail.kf.setImage(with: URL.init(string: item.cover),
                                      placeholder: UIImage.imageWithNamed("sampleGoodsInCategoryCell"),
                                      options: [.transition(.fade(1))])
            }
        }
    }
    
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("sampleGoodsInCategoryCell"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.mainBodyFont
        title.textAlignment = .center
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
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
        btn.addTarget(self, action: #selector(addToCartFromCategoryItem), for: .touchUpInside)
        return btn
    }()
    

    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    fileprivate func customInit(){
        
        layer.borderWidth = 1
        layer.borderColor = XFConstants.Color.commonBackground.cgColor
        
        titleLabel.text = "拾个苹果圣诞果一箱6个"
        priceLabel.text = "¥ 36"
        
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(cartBtn)
        
        makeCellConstrains()
    }
    
  
    private func makeCellConstrains(){
        thumbnail.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp.top)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(self.thumbnail.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.priceLabel.snp.top)
            make.bottom.equalTo(self.cartBtn.snp.top)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(30)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self.cartBtn.snp.left)
            make.bottom.equalTo(self).offset(0)
        }
        cartBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.size.equalTo(30)
            make.left.equalTo(self.priceLabel.snp.right)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    @objc private func addToCartFromCategoryItem(){
        MBProgressHUD.showSuccess("成功添加到果篮")
        dPrint(dataSource)
    }

    
    
}
