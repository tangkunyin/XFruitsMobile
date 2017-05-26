//
//  FourBillCollectionViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class FourBillCollectionViewCell: UICollectionViewCell {
    
     var badgeBtn:UIButton?
    
    lazy var typeBtn:UIButton = {
        let typeBtn = UIButton()
        typeBtn.setImage(UIImage(named:"apple"), for: .normal)
        return typeBtn
    }()
    
    lazy var typeDescLabel:UILabel = {
        let typeDescLabel = UILabel()
        typeDescLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        typeDescLabel.font  = UIFont.systemFont(ofSize: 10)
        typeDescLabel.textAlignment = NSTextAlignment.center
        return typeDescLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();

    }
    
    func  setUpUI() {
      
        
        addSubview(typeBtn)
        addSubview(typeDescLabel)

        
        typeBtn.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        })
        
        typeDescLabel.snp.makeConstraints({ (make) in
            make.bottom.equalTo(snp.bottom).offset(0)
            make.left.equalTo(snp.left).offset(0)
            make.right.equalTo(snp.right).offset(0)
            make.top.equalTo(typeBtn.snp.bottom).offset(10)
        })
    }
}
