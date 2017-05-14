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

class XFruitsViewPager: UIView {
    
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = XFConstants.Color.paleGrey
        pageControl.currentPageIndicatorTintColor = XFConstants.Color.salmon
        pageControl.isEnabled = true
        return pageControl
    }()
    
    lazy var container:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView;
    }()
    
    var pagerDidClicked: ((Int) -> Void)?
    
    
    convenience init(source:Array<String>, placeHolder:String?)  {
        
        self.init()
        
        self.addSubview(self.container)
        container.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(self)
        }
        
        for (index, item) in source.enumerated() {
            let pageView = imagePagerView(urlString: item, placeHolder: placeHolder, index: index)
            self.container.addSubview(pageView)
            pageView.snp.makeConstraints({ (make) in
                make.top.size.equalTo(self.container)
                if index == 0 {
                    make.left.equalTo(self.container)
                }
                else if let previousView = self.container.subviews[index-1] as? UIImageView {
                    make.left.equalTo(previousView.snp.right).offset(0)
                }
                if index == source.count - 1 {
                    make.right.equalTo(self.container)
                }
            })
        }
        
        self.pageControl.numberOfPages = source.count
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 200, height:40))
            make.bottom.equalTo(0)
        }
    }
    
    private func imagePagerView(urlString:String,placeHolder:String?,index:Int) -> UIImageView {
        
        var placeHolderImage:UIImage? = nil
        if let placeHolder = placeHolder {
            placeHolderImage = UIImage.imageWithNamed(placeHolder)
        }
        
        let pageView = UIImageView()
        pageView.tag = index
        pageView.contentMode = .scaleAspectFit
        pageView.kf.setImage(with: URL(string: urlString),
                             placeholder: placeHolderImage,
                             options: [.transition(.fade(1))],
                             progressBlock: nil,
                             completionHandler: nil)
        pageView.isUserInteractionEnabled = true
        pageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        
        return pageView
    }
    
    @objc private func pagerClicked(_ tap:UITapGestureRecognizer) {
        if let pagerView = tap.view, let pagerClicked = self.pagerDidClicked {
            pagerClicked(pagerView.tag)
        }
    }
}
