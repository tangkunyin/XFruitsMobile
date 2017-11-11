//
//  XFRowInputView.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/11.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFRowInputView: UIView {

    public lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = XFConstants.Color.darkGray
        tipLabel.font  = XFConstants.Font.pfn14
        tipLabel.textAlignment = .center
        return tipLabel
    }()
    
    public lazy var textInput: UITextField = {
        let textInput = UITextField()
        textInput.returnKeyType = .done
        textInput.clearButtonMode = .whileEditing
        textInput.textColor  = XFConstants.Color.darkGray
        textInput.font = XFConstants.Font.pfn14
        return textInput
    }()
    
    convenience init(title: String, placeHolder: String, tag: Int, delegate: UITextFieldDelegate?, inputEnable: Bool = true)  {
        self.init()
        
        backgroundColor = UIColor.white
        addSubview(tipLabel)
        addSubview(textInput)
        
        tipLabel.text = title
        
        textInput.tag = tag
        textInput.placeholder = placeHolder
        textInput.delegate = delegate
        textInput.isEnabled = inputEnable
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(80)
            make.right.equalTo(textInput.snp.left).offset(10)
        }
        textInput.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
    }
    
}
