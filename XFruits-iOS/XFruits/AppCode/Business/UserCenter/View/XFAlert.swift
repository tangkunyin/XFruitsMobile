//
//  XFAlert.swift
//  XFruits
//
//  Created by zhaojian on 8/5/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAlert: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();
    }
    
    lazy var bgView:UIView = {
        let bgView = UIView.init()  // frame: CGRect.init(x: 0, y: 0, width:  self.frame.size.width, height:  self.frame.height)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bgView
    }()
    
    lazy var alertView:UIView = {
        let alertView = UIView.init()  // frame: CGRect.init(x: 30, y:  self.frame.height/2 - 90, width:  self.frame.size.width - 60, height: 180)
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 8
        return alertView
    }()
    
    lazy var titleLabel:UILabel  = {
        let titleLabel  = UILabel.init()
        titleLabel.text = "请输入新的类别"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    lazy var cateTextField:UITextField  = {
        let cateTextField = UITextField.init()
        cateTextField.layer.borderWidth  = 0.5
        cateTextField.layer.borderColor = UIColor.lightGray.cgColor
        cateTextField.layer.cornerRadius = 5
        cateTextField.placeholder = "请输入类别"
        cateTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        return cateTextField
    }()
    
    lazy var cancelBtn:UIButton = {
        let cancelBtn = UIButton.init(type: .custom)
        
        cancelBtn.frame = CGRect.init()
        cancelBtn.backgroundColor = UIColor.lightGray
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var sureBtn:UIButton = {
        let sureBtn = UIButton.init(type: .custom)
        
        sureBtn.frame = CGRect.init()
        sureBtn.backgroundColor = UIColor.orange
        sureBtn.setTitle("确定", for: .normal)
        cancelBtn.addTarget(self, action: #selector(sureEvent), for: .touchUpInside)

        return sureBtn
    }()
    
    func setUpUI()  {
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints({ (make) in
            make.left.top.bottom.right.equalTo(self)
        })
        
        
        bgView.addSubview(alertView)
        alertView.snp.makeConstraints({ (make) in
            make.center.equalTo(bgView)
            make.width.equalTo(XFConstants.UI.deviceWidth - 60)
            make.height.equalTo(180)
        })
        
        
        alertView.addSubview(titleLabel)
      
        titleLabel.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(alertView)
 
            make.height.equalTo(50)
        })
      
        alertView.addSubview(cateTextField)
        // frame: CGRect.init(x: 15, y: titleLabel.frame.size.height+10, width: alertView.frame.size.width-30, height: 50)
        cateTextField.snp.makeConstraints({ (make) in
            make.left.equalTo(alertView).offset(15)
            make.right.equalTo(alertView).offset(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
          
            make.height.equalTo(50)
        })
        
        alertView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(alertView.snp.left).offset(15)
            make.top.equalTo(cateTextField.snp.bottom).offset(20)

            make.height.equalTo(40)
        })
        
        alertView.addSubview(sureBtn)
        
        sureBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(15)
            make.top.equalTo(cateTextField.snp.bottom).offset(20)
           make.right.equalTo(alertView.snp.right).offset(-15)
            make.width.equalTo(cancelBtn.snp.width)
   
            make.height.equalTo(40)
        })
        
    }
    
    @objc func cancelEvent()  {
    
        self.removeFromSuperview()
    }
    
    @objc func sureEvent()  {
        
        self.removeFromSuperview()
    }

}
