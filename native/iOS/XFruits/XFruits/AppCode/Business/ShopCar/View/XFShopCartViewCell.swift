//
//  XFShopCartViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class XFShopCartViewCell: UITableViewCell {

    lazy var radioBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_uncheck"), for: .normal)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_check"), for: .selected)
        return btn
    }()
    
    lazy var plusBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.setTitleColor(grayColor(200), for: .disabled)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        return btn
    }()
    
    lazy var minusBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.setTitleColor(grayColor(200), for: .disabled)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        return btn
    }()
    
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("sampleGoodsInCategoryCell"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.mainBodyFont
        title.textAlignment = .left
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
        title.lineBreakMode = .byTruncatingTail
        title.text = "拾个鲜果开心圣诞果6个装"
        return title
    }()
    
    lazy var descLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.bottomMenuFont
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        title.text = "规格：6个 80mm"
        return title
    }()
    
    lazy var priceLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.bottomMenuFont
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        title.text = "¥ 38"
        return title
    }()
    
    lazy var quanityLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.bottomMenuFont
        title.textAlignment = .center
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = false
        title.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        title.layer.borderColor = XFConstants.Color.darkGray.cgColor
        title.text = "2"
        return title
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    fileprivate func customInit(){
        
        addSubview(radioBtn)
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(priceLabel)
        addSubview(minusBtn)
        addSubview(quanityLabel)
        addSubview(plusBtn)
        
        radioBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.size.equalTo(16)
            make.left.equalTo(self.snp.left).offset(10)
        }
        thumbnail.snp.makeConstraints { (make) in
            make.size.equalTo(90)
            make.left.equalTo(self.radioBtn.snp.right).offset(10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(25)
            make.top.equalTo(self.thumbnail.snp.top).offset(5)
            make.bottom.equalTo(self.descLabel.snp.top)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.height.equalTo(25)
            make.right.equalTo(self.minusBtn.snp.left)
            make.bottom.equalTo(self.thumbnail.snp.bottom).offset(0)
        }
        minusBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 18))
            make.left.equalTo(self.priceLabel.snp.right)
            make.right.equalTo(self.quanityLabel.snp.left)
            make.bottom.equalTo(self.priceLabel.snp.bottom).offset(0)
        }
        quanityLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 18))
            make.left.equalTo(self.minusBtn.snp.right)
            make.right.equalTo(self.plusBtn.snp.left)
            make.bottom.equalTo(self.minusBtn.snp.bottom)
        }
        plusBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 18))
            make.left.equalTo(self.quanityLabel.snp.right)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self.quanityLabel.snp.bottom)
        }
    
    }
    
    

}
