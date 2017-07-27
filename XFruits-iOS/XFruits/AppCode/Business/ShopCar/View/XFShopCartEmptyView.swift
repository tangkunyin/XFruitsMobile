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
                tipLabel.text = "拾个农夫提醒：您的果篮还未采摘水果喔~"
                tipLabel.textColor = XFConstants.Color.coolGrey
            case 2:
                tipLabel.text = "依旧没有鲜果哎，去隔壁看看吧 ^_^ "
                tipLabel.textColor = XFConstants.Color.purpleyGrey
            case 3:
                tipLabel.text = "没找到隔壁吗？就在你左手边啊 ：）"
                tipLabel.textColor = XFConstants.Color.darkGray
            case 4:
                tipLabel.text = "还没找到果实？老夫我也是醉了..."
                tipLabel.textColor = XFConstants.Color.salmon
            default:break
            }
        }
    }
    
    
    lazy var tipImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("xfruits-farmer-2"))
        return imageView
    }()
    
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.mainMenuFont
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
    
    private func customInit(){
        addSubview(tipImageView)
        addSubview(tipLabel)
        tipImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 160, height: 151))
        }
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.tipImageView.snp.bottom).offset(20)
            make.left.right.equalTo(self)
            make.height.equalTo(44)
        }
    }
    
}
