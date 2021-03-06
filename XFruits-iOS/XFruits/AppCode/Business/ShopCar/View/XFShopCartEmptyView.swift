//
//  XFShopCartEmptyView.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/16.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFShopCartEmptyView: UIView {


    var viewCount: Int {
        get {
            return 0
        }
        set (count) {
            switch count {
            case 1:
                tipLabel.text = "不论再忙也要买点水果犒劳自己喔~"
                tipLabel.textColor = XFConstants.Color.salmon
            case 2:
                tipLabel.text = "去左边的水货市场看看呗"
                tipLabel.textColor = XFConstants.Color.darkGray
            case 3:
                tipLabel.text = "没有想吃的也可以去右边调戏客服嘛"
                tipLabel.textColor = XFConstants.Color.purpleyGrey
            case 4:
                tipLabel.text = "不想买就算啦，表点来点去好吧..."
                tipLabel.textColor = XFConstants.Color.coolGrey
            default:
                break
            }
        }
    }
    
    
    lazy var tipImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("xfruits-farmer-2"))
        return imageView
    }()
    
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment = .center
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
    
    fileprivate func customInit(){
        addSubview(tipImageView)
        addSubview(tipLabel)
        tipImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(135)
            make.size.equalTo(CGSize.init(width: 160, height: 151))
        }
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.tipImageView.snp.bottom).offset(20)
            make.left.right.equalTo(self)
            make.height.equalTo(44)
        }
    }
    
}
