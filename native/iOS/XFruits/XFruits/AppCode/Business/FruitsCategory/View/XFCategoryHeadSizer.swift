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
        segmente.tintColor = XFConstants.Color.commonBackground
        segmente.addTarget(self, action: #selector(sizerChangedAction(_:)), for: .valueChanged)
        return segmente
    }()
    

    convenience init(textColor:UIColor?, selectTextColor:UIColor?) {
        self.init()
        
        let normalAttributes = [NSAttributedStringKey.foregroundColor:textColor ?? XFConstants.Color.darkGray,
                                NSAttributedStringKey.font:pfnFontWithSize(14)]
        let selectAttributes = [NSAttributedStringKey.foregroundColor:selectTextColor ?? colorWithRGB(255, g: 102, b: 102),
                                NSAttributedStringKey.font:pfnFontWithSize(14)]
        
        sizer.setTitleTextAttributes(normalAttributes, for: .normal)
        sizer.setTitleTextAttributes(selectAttributes, for: .selected)
        
        
        addSubview(sizer)
    
        sizer.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    @objc private func sizerChangedAction(_ segment:UISegmentedControl){
        let status:Int = segment.selectedSegmentIndex + 1;
        dPrint("\(status)")
    }

}
