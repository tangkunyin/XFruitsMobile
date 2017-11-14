//
//  FourBillCollectionViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class FourBillCollectionViewCell: UICollectionViewCell {
    
    lazy var typeIcon:UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.isUserInteractionEnabled = false
        return icon
    }()
    
    lazy var typeDescLabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font  = XFConstants.Font.pfn14
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();
    }
    
    fileprivate func setUpUI() {
        addSubview(typeIcon)
        addSubview(typeDescLabel)
        typeIcon.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(snp.top).offset(10)
            make.size.equalTo(CGSize(width: 35, height: 35))
        })
        typeDescLabel.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(typeIcon.snp.bottom).offset(5)
            make.height.equalTo(25)
        })
    }
}
