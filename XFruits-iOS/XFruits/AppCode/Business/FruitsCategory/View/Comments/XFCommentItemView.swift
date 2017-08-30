//
//  XFCommentItemView.swift
//  XFruits
//
//  Created by tangkunyin on 29/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class XFCommentItemView: UIView {
    
    var data: XFComment? {
        didSet {
            userAvatar.kf.setImage(with: URL(string: data!.avatar),
                                   placeholder: UIImage.imageWithNamed("logo"),
                                   options: [.transition(.fade(1))])
            userName.text = data!.username
            commentDate.text = stringDateByTimestamp(timeStamp: data!.createAt/1000)
            contentLabel.attributedText = renderCommentAttriText(text: data!.content)
        }
    }

    lazy var userAvatar : UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 21
        avatar.layer.masksToBounds = true
        avatar.clipsToBounds = true
        return avatar
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "小果拾"
        return label
    }()
    
    lazy var commentDate: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.text = "2017-04-01 05:36"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    fileprivate func customInit(){
        
        backgroundColor = UIColor.white
        layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        
        addSubview(userAvatar)
        addSubview(userName)
        addSubview(commentDate)
        addSubview(contentLabel)
        
        userAvatar.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.size.equalTo(42)
            make.bottom.equalTo(self.contentLabel.snp.top).offset(-5)
        }
        userName.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userAvatar.snp.right).offset(10)
            make.width.equalTo(self.commentDate.snp.width)
            make.bottom.equalTo(self.contentLabel.snp.top).offset(-5)
        }
        commentDate.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userName.snp.right)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(self.userName.snp.width)
            make.bottom.equalTo(self.contentLabel.snp.top).offset(-5)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(5)
            make.left.equalTo(self).offset(10)
            make.right.bottom.equalTo(self).offset(-10)
            make.height.lessThanOrEqualTo(115.6)
        }
        
    }
    
    fileprivate func renderCommentAttriText(text:String?) -> NSAttributedString {
        var defaultText = "你是我滴小丫小苹果，怎么买你都不嫌多..."
        if let text = text {
            defaultText = text
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attributes = [NSFontAttributeName:XFConstants.Font.pfn14,
                          NSForegroundColorAttributeName:XFConstants.Color.darkGray,
                          NSParagraphStyleAttributeName:paragraphStyle];
        let attributeText = NSAttributedString.init(string: defaultText, attributes: attributes)
        return attributeText
    }

}
