//
//  XFViewPager.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class XFViewPager: UIView, UIScrollViewDelegate {
    
    var placeHolder:String?
    
    public var pagerDidClicked: ((Int) -> Void)?
    
    public var dataSource:Array<String>? {
        didSet {
            if let imageSource = dataSource {
                if self.container.subviews.count > 0 {
                    self.container.subviews.forEach {$0.removeFromSuperview()}
                }
                renderPager(source: imageSource)
            }
        }
    }
    
    convenience init(placeHolder:String?)  {
        self.init()
        self.addSubview(self.container)
        container.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        }
        self.placeHolder = placeHolder
        self.container.bounds.origin = CGPoint.init(x: 0, y: 0)
    }
    
    convenience init(source:Array<String>, placeHolder:String?)  {
        self.init(placeHolder: placeHolder)
        renderPager(source: source)
    }
    
    fileprivate func renderPager(source:Array<String>){
        if source.count == 1 {
            let singleView:UIImageView = imagePagerView(urlString: source.first!, placeHolder: placeHolder, index: 0)
            self.container.addSubview(singleView)
            singleView.snp.makeConstraints({ (make) in
                make.center.size.equalTo(self.container)
            })
        } else if source.count > 1 {
            // render views
            for (index, item) in source.enumerated() {
                let pageView:UIImageView = imagePagerView(urlString: item, placeHolder: placeHolder, index: index)
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
            // render page control view
            self.pageControl.numberOfPages = source.count
            self.addSubview(self.pageControl)
            self.pageControl.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.size.equalTo(CGSize(width: 200, height:40))
                make.bottom.equalTo(0)
            }
        }
    }
    
    fileprivate lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = XFConstants.Color.paleGrey
        pageControl.currentPageIndicatorTintColor = XFConstants.Color.salmon
        pageControl.isEnabled = false
        return pageControl
    }()
    
    fileprivate lazy var container:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView;
    }()
    
    // MARK: - paging start
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / XFConstants.UI.deviceWidth;
        self.pageControl.currentPage = Int(page);
    }
    
    // MARK: - fileprivate funcs
    fileprivate func imagePagerView(urlString:String,placeHolder:String?,index:Int) -> UIImageView {
        
        var placeHolderImage:UIImage? = nil
        if let placeHolder = placeHolder {
            placeHolderImage = UIImage.imageWithNamed(placeHolder)
        }
        
        let pageView = UIImageView()
        pageView.tag = index
        pageView.contentMode = .scaleAspectFill
        pageView.layer.masksToBounds = true
        pageView.clipsToBounds = true
        pageView.isUserInteractionEnabled = true
        pageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        pageView.kf.setImage(with: URL(string: urlString),
                             placeholder: placeHolderImage,
                             options: [.transition(.fade(1))],
                             progressBlock: nil,
                             completionHandler: nil)
        return pageView
    }
    
    @objc fileprivate func pagerClicked(_ tap:UITapGestureRecognizer) {
        if let pagerView = tap.view, let pagerClicked = self.pagerDidClicked {
            pagerClicked(pagerView.tag)
        }
    }
}

