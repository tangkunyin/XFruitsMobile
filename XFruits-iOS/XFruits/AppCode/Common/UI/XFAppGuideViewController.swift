//
//  XFAppGuideViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/26.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAppGuideViewController: UIViewController {

    fileprivate let guideImageSource: Array<String> = ["guide_bg1", "guide_bg2", "guide_bg3"]
    
    fileprivate lazy var guideBackgroundView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var guidePageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = XFConstants.Color.paleGrey
        pageControl.currentPageIndicatorTintColor = XFConstants.Color.salmon
        pageControl.isEnabled = false
        return pageControl
    }()
    
    fileprivate lazy var closeGuideBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("开启艺术生活", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.backgroundColor = XFConstants.Color.salmon
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(closeGuideClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderGuidePagerView()
    }
    
    @objc fileprivate func closeGuideClick() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.65, animations: {
            weakSelf?.view.transform = CGAffineTransform(scaleX: 1.8, y: 1.8);
        }) { (flag) in
            weakSelf?.dismiss(animated: false) {
                weakSelf?.guideBackgroundView.delegate = nil
            }
        }
    }

    fileprivate func renderGuidePagerView() {
        view.addSubview(guideBackgroundView)
        guideBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.zero)
        }
        for (index, item) in guideImageSource.enumerated() {
            let pageView:UIImageView = UIImageView.init(image: UIImage.imageWithNamed(item))
            pageView.contentMode = .scaleAspectFill
            pageView.layer.masksToBounds = true
            pageView.clipsToBounds = true
            pageView.isUserInteractionEnabled = true
            guideBackgroundView.addSubview(pageView)
            pageView.snp.makeConstraints({ (make) in
                make.top.size.equalTo(guideBackgroundView)
                if index == 0 {
                    make.left.equalTo(guideBackgroundView)
                }
                else if let previousView = guideBackgroundView.subviews[index-1] as? UIImageView {
                    make.left.equalTo(previousView.snp.right).offset(0)
                }
                if index == guideImageSource.count - 1 {
                    make.right.equalTo(guideBackgroundView)
                    // 插入关闭按钮
                    pageView.addSubview(closeGuideBtn)
                    closeGuideBtn.snp.makeConstraints({ (make) in
                        make.size.equalTo(CGSize.init(width: 120, height: 35))
                        make.centerX.equalTo(pageView)
                        make.bottom.equalTo(pageView).offset(-60)
                    })
                }
            })
        }
        
        // render page control view
        guidePageControl.numberOfPages = guideImageSource.count
        view.addSubview(guidePageControl)
        guidePageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height:40))
            make.bottom.equalTo(0)
        }
    }
}

extension XFAppGuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / XFConstants.UI.deviceWidth;
        self.guidePageControl.currentPage = Int(page);
    }
}
