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

    lazy var userAvatar : UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 21
        avatar.layer.masksToBounds = true
        avatar.clipsToBounds = true
        avatar.kf.setImage(with: URL(string: "http://file-www.sioe.cn/201012/5/1655299809.jpg"),
                             placeholder: nil,
                             options: [.transition(.fade(1))],
                             progressBlock: nil,
                             completionHandler: nil)
        return avatar
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.mainMenuFont
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "独孤求**"
        return label
    }()
    
    lazy var commentDate: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.mainMenuFont
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
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attributes = [NSFontAttributeName:XFConstants.Font.mainMenuFont,
                          NSForegroundColorAttributeName:XFConstants.Color.darkGray,
                          NSParagraphStyleAttributeName:paragraphStyle];
        
        let text = "乌云在我们心里搁下一块阴影，我聆听沉寂已久的心情清。晰透明就像美丽的风景，总在回忆里才看的清。被伤透的心能不能够继续爱我，我用力牵起没温度的双手。过往温柔 已经被时间上锁，只剩挥散不去的难过。缓缓飘落的枫叶像思念，我点燃烛火温暖岁末的秋天。极光掠夺天边，北风掠过想你的容颜。我把爱烧成了落叶，却换不回熟悉的那张脸。缓缓飘落的枫叶像思念，为何挽回要赶在冬天来之前。爱你穿越时间，两行来自秋末的眼泪。让爱渗透了地面，我要的只是你在我身边。"
        let attributeText = NSAttributedString.init(string: text, attributes: attributes)
        label.attributedText = attributeText
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
    
    private func customInit(){
        
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
            make.bottom.equalTo(self.contentLabel.snp.top)
        }
        userName.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userAvatar.snp.right).offset(10)
            make.width.equalTo(self.commentDate.snp.width)
            make.bottom.equalTo(self.contentLabel.snp.top)
        }
        commentDate.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userName.snp.right)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(self.userName.snp.width)
            make.bottom.equalTo(self.contentLabel.snp.top)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.right.bottom.equalTo(self).offset(-10)
            make.height.lessThanOrEqualTo(115.6)
        }
        
    }

}
