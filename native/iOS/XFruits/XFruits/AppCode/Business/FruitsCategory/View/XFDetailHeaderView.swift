//
//  XFDetailHeaderView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

/// 详情页首部商品介绍、幻灯片
class XFDetailHeaderView: UIView {

    lazy var detailViewPager: XFruitsViewPager = {
        let pager = XFruitsViewPager.init(source: [""], placeHolder: "default-apple")
        return pager
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.titleFont
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .center
        label.text = "拾个鲜果圣诞果一箱6个"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.mainMenuFont
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        label.text = "¥ 39.00"
        return label
    }()
    
    lazy var specificationDescLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.mainMenuFont
        label.textColor = XFConstants.Color.greyishBrown
        label.textAlignment = .left
        label.text = "规格： 一箱6个、直径85mm"
        return label
    }()
    
    lazy var serviceTitleLabel: UILabel = {
        let label = UILabel();
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit(){
    
    }

}
