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
        icon.isUserInteractionEnabled = false
        return icon
    }()
    
    lazy var typeDescLabel:UILabel = {
        let label = UILabel()
        label.textColor = colorWithRGB(83, g: 83, b: 83)
        label.font  = XFConstants.Font.pfn12
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
    
    private func setUpUI() {
        addSubview(typeIcon)
        addSubview(typeDescLabel)
        typeIcon.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize.init(width: 26, height: 26))
            make.centerX.equalTo(self)
        })
        typeDescLabel.snp.makeConstraints({ (make) in
            make.bottom.equalTo(snp.bottom).offset(0)
            make.left.equalTo(snp.left).offset(0)
            make.right.equalTo(snp.right).offset(0)
            make.top.equalTo(typeIcon.snp.bottom).offset(10)
        })
    }
}
