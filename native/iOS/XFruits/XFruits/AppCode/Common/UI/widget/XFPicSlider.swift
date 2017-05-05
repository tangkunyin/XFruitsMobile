//
//  XFPicSlider.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/23.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

public enum PageControlStyle {
    case centerPager
    case rightPager
}

class XFPicSlider: UIView {

    public var style:PageControlStyle //设置PageControl位置
    
    public var autoScrollDelay:TimeInterval //自动滚屏延迟时间，单位为秒
    
    public var font:UIFont?
    
    public var imageSource:Array<String>? //如果从网络加载，则该参数为合法可用的URLs，否则将使图片名称数组
    
    public var titleData:Array<String>? //设置后显示label,自动设置PageControlAtRight
    
    public var pageIndicatorTintColor,currentPageIndicatorTintColor,textColor:UIColor?
    
    public var imageViewDidTapAtIndex:((Int)->Void)?; //图片被点击会触发此闭包，索引从0开始
    
    // ------------- privae var -------------------- //
    
    fileprivate lazy var myWidth:CGFloat = {
        return self.frame.size.width
    }()
    
    fileprivate lazy var myHeight:CGFloat = {
        return self.frame.size.height
    }()
    
    fileprivate lazy var pageSize:CGFloat = {
        let height = self.myHeight;
        return height * 0.2 > 25 ? 25 : height * 0.2
    }()

    private var imageData:Dictionary<String,Any>?
    
    private var leftImageView,centerImageView,rightImageView:UIImageView?
    
    private var titleLabel:UILabel?
    
    private var scrollView:UIScrollView?
    
    private var pageControl:UIPageControl?
    
    private var timer:Timer?
    
    private var currentIndex,maxImageCount:Int?
    
    private var isNetwork,hasTitle:Bool?
    
    
    override init(frame: CGRect) {
        // 设置默认值
        style = .centerPager
        autoScrollDelay = 3.0
        super.init(frame: frame)
    }
    

    /// 通过传入图片urls或本地图片名称数组初始化轮播组件
    ///
    /// - Parameters:
    ///   - frame: 滚动图大小
    ///   - source: 如果从网络加载，则该参数为合法可用的URLs，否则将使图片名称数组
    ///   - placeHolderName: 占位图名称
    convenience init?(frame:CGRect, source:Array<String>, placeHolderName:String)  {
        if source.count < 1 {
            return nil
        }
        self.init(frame: frame)
        imageSource = source
        
        if source.count == 1 {
            
            let placeHolderImageView = UIImageView.init(frame: self.bounds)
            placeHolderImageView.image = UIImage.imageWithNamed(placeHolderName)
            placeHolderImageView.isUserInteractionEnabled = true
            let userTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(imageViewDidTap))
            placeHolderImageView.addGestureRecognizer(userTapGesture)
            
            self.addSubview(placeHolderImageView)
        } else {
            
            
            
        }
    }
    
    
    func imageViewDidTap() {
        if (imageViewDidTapAtIndex != nil) {
            imageViewDidTapAtIndex?(currentIndex ?? 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
