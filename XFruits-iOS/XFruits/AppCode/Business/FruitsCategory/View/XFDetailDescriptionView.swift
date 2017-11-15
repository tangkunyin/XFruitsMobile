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

    var dataSource:ProductDetail? {
        didSet {
            renderDescriptionsView(descSource: dataSource!.description)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.backgroundColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 10
        let attributes = [NSAttributedStringKey.font:XFConstants.Font.pfn14,
                          NSAttributedStringKey.foregroundColor:XFConstants.Color.darkGray,
                          NSAttributedStringKey.paragraphStyle:paragraphStyle];
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
    
    fileprivate func customInit(){
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

    }
    
    fileprivate func renderDescriptionsView(descSource: Array<String>) {
        for (index, item) in descSource.enumerated() {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
            descBackgroundView.addSubview(imageView)
            
            var imgViewHeightConstraint: Constraint?
            imageView.snp.makeConstraints({ (make) in
                make.width.equalTo(self.descBackgroundView)
                imgViewHeightConstraint = make.height.equalTo(240).constraint
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
            weak var weakSelf = self
            imageView.kf.setImage(with: URL.init(string: item),
                                  placeholder: UIImage.imageWithNamed("Loading-transprent"),
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: { (image, error, type, url) in
                                    if let image = image {
                                        let size = image.size
                                        let newOffset = floor(XFConstants.UI.deviceWidth/(size.width / size.height))
                                        imgViewHeightConstraint?.update(offset: newOffset)
                                        weakSelf?.descBackgroundView.setNeedsUpdateConstraints()
                                    }
            })
        }
    }

}
