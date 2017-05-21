//
//  XFCategoryHeadSizer.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFCategoryHeadSizer: UIView {

    lazy var sizer:UISegmentedControl = {
        let segmente = UISegmentedControl(items: ["综合","销量","新品","价格"])
        segmente.selectedSegmentIndex = 0
        segmente.apportionsSegmentWidthsByContent = true
        segmente.tintColor = UIColor.white
        segmente.addTarget(self, action: #selector(sizerChangedAction(_:)), for: .valueChanged)
        return segmente
    }()
    
    lazy var bottomLine:UIView = {
        let line = UIView();
        line.backgroundColor = grayColor(204)
        return line
    }()
    
    convenience init(textColor:UIColor?, selectTextColor:UIColor?) {
        self.init()
        
        let normalAttributes = [NSForegroundColorAttributeName:textColor ?? grayColor(102),
                                NSFontAttributeName:pfnFontWithSize(14)]
        let selectAttributes = [NSForegroundColorAttributeName:selectTextColor ?? colorWithRGB(255, g: 102, b: 102),
                                NSFontAttributeName:pfnFontWithSize(14)]
        
        sizer.setTitleTextAttributes(normalAttributes, for: .normal)
        sizer.setTitleTextAttributes(selectAttributes, for: .selected)
        
        
        addSubview(sizer)
        addSubview(bottomLine)
        sizer.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.bottomLine.snp.top)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(self.sizer.snp.bottom)
            make.height.equalTo(0.6)
            make.left.right.equalTo(self)
        }
    }
    
    @objc private func sizerChangedAction(_ segment:UISegmentedControl){
        let status:Int = segment.selectedSegmentIndex + 1;
        print("\(status)")
    }

}
