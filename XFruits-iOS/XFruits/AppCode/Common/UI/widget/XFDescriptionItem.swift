//
//  XFDescriptionItem.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

/// 左标题右描述型组件
class XFDescriptionItem: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.mainMenuFont
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.mainMenuFont
        label.textAlignment = .right
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = XFConstants.Color.separatorLine
        return lineView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    private func customInit(){
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(separatorLine)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.left.equalTo(titleLabel.snp.right)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
