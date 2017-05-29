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
    
    lazy var contentText: UITextView = {
        let textView = UITextView()
        textView.text = "乌云在我们心里搁下一块阴影，我聆听沉寂已久的心情清。晰透明就像美丽的风景，总在回忆里才看的清。被伤透的心能不能够继续爱我，我用力牵起没温度的双手 ..."
        return textView
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
        
        layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        
        addSubview(userAvatar)
        addSubview(userName)
        addSubview(commentDate)
        addSubview(contentText)
        
        userAvatar.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.size.equalTo(42)
        }
        userName.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userAvatar.snp.right).offset(10)
        }
        commentDate.snp.makeConstraints { (make) in
            make.top.height.equalTo(self.userAvatar)
            make.left.equalTo(self.userName.snp.right)
            make.right.equalTo(self).offset(-10)
        }
        contentText.snp.makeConstraints { (make) in
            make.top.equalTo(userAvatar.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self)
            make.height.lessThanOrEqualTo(115.6)
        }
        
    }

}
