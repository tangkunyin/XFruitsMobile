//
//  XFDetailDescriptionView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


/// 详情页底部商品图文介绍
class XFDetailDescriptionView: UIView {

    let descSource:Array<String> = ["default-detailIntroduce","default-apple"]
    
    deinit {
        print("XFDetailDescriptionView deinit...")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.backgroundColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 10
        let attributes = [NSFontAttributeName:XFConstants.Font.mainMenuFont,
                          NSForegroundColorAttributeName:XFConstants.Color.darkGray,
                          NSParagraphStyleAttributeName:paragraphStyle];
        let attributeText = NSAttributedString.init(string: "商品详情", attributes: attributes)
        label.attributedText = attributeText
        return label
    }()
    
    lazy var descBackgroundView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
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
        backgroundColor = UIColor.white
    
        let line:UIView = createSeperateLine()
        
        addSubview(titleLabel)
        addSubview(line)
        addSubview(descBackgroundView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.width.equalTo(self)
            make.height.equalTo(42)
            make.bottom.equalTo(line.snp.top)
        }
        line.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.width.equalTo(self)
            make.height.equalTo(0.4)
            make.bottom.equalTo(self.descBackgroundView.snp.top)
        }
        descBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom)
            make.width.bottom.equalTo(self)
        }
        
        for (index, item) in descSource.enumerated() {
            let imageView = UIImageView.init(image: UIImage.imageWithNamed(item))
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
            descBackgroundView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.width.equalTo(self.descBackgroundView)
                if index == 0 {
                    make.top.equalTo(self.descBackgroundView)
                }
                else if let previousView = self.descBackgroundView.subviews[index-1] as? UIImageView {
                    make.top.equalTo(previousView.snp.bottom).offset(0)
                }
                if index == descSource.count - 1 {
                    make.bottom.equalTo(self.descBackgroundView)
                }
            })
        }
        
    }

}
