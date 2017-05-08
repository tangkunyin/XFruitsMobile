//
//  XFruitsViewPager.swift
//  XFruits
//
//  Created by tangkunyin on 2017/5/5.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class XFruitsViewPager: UIScrollView {


    convenience init?(source:Array<String>, placeHolder:String?)  {
        
        if source.count < 1 {
            return nil
        }
        
        self.init()
    
        
        let placeHolderImage = (placeHolder ?? nil) == nil ? nil : UIImage.imageWithNamed(placeHolder!)
        
    
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = XFConstants.Color.paleGrey
        pageControl.currentPageIndicatorTintColor = XFConstants.Color.salmon
        pageControl.isEnabled = true
        pageControl.numberOfPages = source.count
        
        for (index, item) in source.enumerated() {
            let pageView = UIImageView()
            pageView.tag = index
            pageView.kf.setImage(with: URL(string: item),
                                 placeholder: placeHolderImage,
                                 options: [.transition(.fade(1))],
                                 progressBlock: nil,
                                 completionHandler: nil)
            pageView.isUserInteractionEnabled = true
            self.addSubview(pageView)
            
            pageView.snp.makeConstraints({ (make) in
                make.size.equalTo(self)
                make.top.equalTo(self)
                make.left.equalTo(CGFloat(index) * CGFloat(self.snp.left))
                
                
            })
        }
        self.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height:50))
            make.centerX.equalTo(self.center)
            make.bottom.equalTo(20)
        }
        
        self.contentSize = CGSize(width: frame.width * CGFloat(source.count), height: frame.height)
    }
    

}
