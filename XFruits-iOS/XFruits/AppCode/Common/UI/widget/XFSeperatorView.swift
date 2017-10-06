//
//  XFSeperatorView.swift
//  XFruits
//
//  Created by tangkunyin on 2017/10/1.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFSeperatorView: UIView {

    lazy var leftLine: UIView = {
        let view = createSeperateLine()
        view.backgroundColor = XFConstants.Color.tipTextGrey
        return view
    }()
    
    lazy var rightLine: UIView = {
        let view = createSeperateLine()
        view.backgroundColor = XFConstants.Color.tipTextGrey
        return view
    }()
    
    lazy var seperateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "随便看看"
        label.font = XFConstants.Font.pfn16
        label.textAlignment = .center
        label.textColor = XFConstants.Color.tipTextGrey
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
        addSubview(seperateTextLabel)
        addSubview(leftLine)
        addSubview(rightLine)
        seperateTextLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 110, height: 40))
        }
        leftLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 65, height: 1))
            make.right.equalTo(seperateTextLabel.snp.left).offset(-5)
        }
        rightLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 65, height: 1))
            make.left.equalTo(seperateTextLabel.snp.right).offset(5)
        }
    }
    
}
