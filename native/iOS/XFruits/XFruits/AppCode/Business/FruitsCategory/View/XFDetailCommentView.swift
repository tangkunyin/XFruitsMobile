//
//  XFDetailCommentView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

/// 详情页中部商品评论
class XFDetailCommentView: UIView {

    var dataSource:ProductDetail? {
        didSet {
            
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
        let attributes = [NSFontAttributeName:XFConstants.Font.mainMenuFont,
                          NSForegroundColorAttributeName:XFConstants.Color.darkGray,
                          NSParagraphStyleAttributeName:paragraphStyle];
        let attributeText = NSAttributedString.init(string: "评论", attributes: attributes)
        label.attributedText = attributeText
        return label
    }()
    
    lazy var showAllBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("查看全部 >", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.titleLabel?.font = XFConstants.Font.mainMenuFont
        btn.contentHorizontalAlignment = .right
        btn.backgroundColor = UIColor.white
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10)
        return btn
    }()
    
    private func customInit(){
        
        let topComment = XFCommentItemView()
        let bottomComment = XFCommentItemView()
        
        addSubview(titleLabel)
        addSubview(showAllBtn)
        addSubview(topComment)
        addSubview(bottomComment)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(41)
            make.bottom.equalTo(topComment.snp.top)
            make.right.equalTo(self.showAllBtn.snp.left)
            make.width.equalTo(self.showAllBtn.snp.width)
        }
        showAllBtn.snp.makeConstraints { (make) in
            make.top.height.width.equalTo(self.titleLabel)
            make.left.equalTo(self.titleLabel.snp.right)
            make.right.equalTo(self)
            make.bottom.equalTo(topComment.snp.top)
        }
        topComment.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.width.equalTo(self)
            make.bottom.equalTo(bottomComment.snp.top)
        }
        bottomComment.snp.makeConstraints { (make) in
            make.top.equalTo(topComment.snp.bottom)
            make.width.bottom.equalTo(self)
        }
    }

}
