//
//  FourBillCollectionViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class FourBillCollectionViewCell: UICollectionViewCell {
    var typeBtn:UIButton?
    var typeDescLabel:UILabel?
    var badgeBtn:UIButton?
    
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI();

    }
    
    func  setUpUI() {
        self.typeBtn  = UIButton.init()
        self.typeBtn?.setImage(UIImage(named:"apple"), for: .normal)
        
        self.addSubview(self.typeBtn!)
        self.typeBtn?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))//将

        })
        
        self.typeDescLabel = UILabel.init()
        self.typeDescLabel?.text = "zhaojian"
        self.typeDescLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
        self.typeDescLabel?.font  = UIFont.systemFont(ofSize: 10)
        self.typeDescLabel?.textAlignment = NSTextAlignment.center
    
        
        self.addSubview(self.typeDescLabel!)
        
        self.typeDescLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo((self.typeBtn?.snp.bottom)!).offset(10)
            //            make.height.equalTo(40)
            //            make.width.equalTo(40)
        })
        
        
    
        
    }
    
    
}
