//
//  XFDetailCommentView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 详情页中部商品评论
class XFDetailCommentView: UIView {

    var dataSource:Array<XFComment>? {
        didSet {
            addCommentList(comments: dataSource!)
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
        let attributes = [NSAttributedStringKey.font:XFConstants.Font.mainMenuFont,
                          NSAttributedStringKey.foregroundColor:XFConstants.Color.darkGray,
                          NSAttributedStringKey.paragraphStyle:paragraphStyle];
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
        btn.addTarget(self, action: #selector(showAllCommentClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var commentContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    private func customInit(){
        addSubview(titleLabel)
        addSubview(showAllBtn)
        addSubview(commentContainer)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(41)
            make.right.equalTo(self.showAllBtn.snp.left)
            make.width.equalTo(self.showAllBtn.snp.width)
            make.bottom.equalTo(commentContainer.snp.top)
        }
        showAllBtn.snp.makeConstraints { (make) in
            make.top.height.width.equalTo(self.titleLabel)
            make.left.equalTo(self.titleLabel.snp.right)
            make.right.equalTo(self)
            make.bottom.equalTo(commentContainer.snp.top)
        }
        commentContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.width.bottom.equalTo(self)
        }
    }
    
    private func addCommentList(comments: Array<XFComment>){
        for (index, comment) in comments.enumerated() {
            if index < XFConstants.detailCommentsLimit - 1 {
                let commentItem = XFCommentItemView()
                commentItem.data = comment
                commentContainer.addSubview(commentItem)
                commentItem.snp.makeConstraints({ (make) in
                    make.width.equalTo(self)
                    if index == 0 {
                        make.top.equalTo(self.titleLabel.snp.bottom)
                    } else if let previousView = commentContainer.subviews[index-1] as? XFCommentItemView {
                        make.top.equalTo(previousView.snp.bottom).offset(0)
                    }
                    if index == comments.count - 1 {
                        make.bottom.equalTo(self)
                    }
                })
            }
        }
        
    }
    
    @objc private func showAllCommentClick() {
        MBProgressHUD.showError("暂无更多评论，敬请期待...")
    }

}
