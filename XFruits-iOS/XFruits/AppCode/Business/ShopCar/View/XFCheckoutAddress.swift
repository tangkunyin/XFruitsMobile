//
//  XFCheckoutAddress.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


/// 结算页地址信息
class XFCheckoutAddress: UIView {

    var dataSource:Any? {
        didSet {
            
        }
    }
    
    lazy var noDataTip: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn18
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        label.text = "请选择一个有效地址，谢谢"
        return label
    }()
    
    lazy var rightArrow: UIImageView = {
        let arrow = UIImageView(image: UIImage.imageWithNamed("right_arrow"))
        arrow.isUserInteractionEnabled = false
        return arrow
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
    
        addSubview(noDataTip)
        addSubview(rightArrow)
        backgroundColor = UIColor.white
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addressManage)))
     
        noDataTip.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
        }
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 12, height: 20))
            make.left.equalTo(noDataTip.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }
    
    @objc private func addressManage(){
        dPrint("卧槽，你干啥呢")
        
    }

}
