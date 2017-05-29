//
//  XFDetailDescriptionView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


/// 详情页底部商品图文介绍
class XFDetailDescriptionView: UIView {

    let descSource:Array<String> = ["default-detailIntroduce","default-apple"]
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.mainMenuFont
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "商品详情"
        label.layer.borderColor = XFConstants.Color.darkGray.cgColor
        label.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        return label
    }()
    
    private lazy var descBackgroundView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
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
    
        addSubview(titleLabel)
        addSubview(descBackgroundView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(30)
            make.bottom.equalTo(self.descBackgroundView.snp.top)
        }
        descBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        
        for (index, item) in descSource.enumerated() {
            let imageView = UIImageView.init(image: UIImage.imageWithNamed(item))
            imageView.contentMode = .scaleAspectFit
            descBackgroundView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.descBackgroundView)
                if index == 0 {
                    make.top.equalTo(self.descBackgroundView)
                }
                else if let previousView = self.descBackgroundView.subviews[index-1] as? UIImageView {
                    make.top.equalTo(previousView.snp.bottom).offset(0)
                }
                if index == descSource.count - 1 {
                    make.bottom.equalTo(self.descBackgroundView)
                }
            })
        }
        
    }
    
}
