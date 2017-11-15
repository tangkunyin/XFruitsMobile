//
//  UserCenterCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import Kingfisher

class UserCenterAvatarCell: UITableViewCell {
  
    var user: XFUser? {
        didSet{
            if let user = user {
                userNameLabel.text = user.username
                identityDescriptionLabel.text = "全宇宙排名: \(user.rank?.rank ?? 1)"
                avatarImageView.kf.setImage(with: URL(string: user.avatar ?? ""),
                                            placeholder: UIImage.imageWithNamed("defaultAvatar"),
                                            options: [.transition(.fade(1))])
            }
        }
    }
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView.init(image: UIImage.imageWithNamed("defaultAvatar"))
        
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.layer.masksToBounds = true
        return avatarImageView
    }()
    
    lazy var userNameLabel:UILabel = {
        let  userNameLabel = UILabel()
        userNameLabel.text = "那个，请登录先"
        userNameLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        userNameLabel.font  = XFConstants.Font.pfn16
        return userNameLabel
    }()
    
    lazy var identityLevelImageView:UIImageView = {
        let identityLevelImageView = UIImageView.init(image: UIImage.imageWithNamed("level-crown"))
        return identityLevelImageView
    }()
    
    lazy var  identityDescriptionLabel:UILabel = {
        let identityDescriptionLabel = UILabel.init()
        identityDescriptionLabel.text = "拾个小鲜肉"
        identityDescriptionLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        identityDescriptionLabel.font  = XFConstants.Font.pfn12
        return identityDescriptionLabel
    }()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    fileprivate func setUpUI(){
        
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        addSubview(userNameLabel)
        addSubview(identityLevelImageView)
        addSubview(identityDescriptionLabel)
        addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(snp.left).offset(10)
            make.width.height.equalTo(70)
            make.centerY.equalTo(self).offset(5)
        })
    
        userNameLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self).offset(-8)
            make.left.equalTo(avatarImageView.snp.right).offset(15)
        })
        
        identityLevelImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel).offset(0)
        })
        
        identityDescriptionLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(identityLevelImageView)
            make.left.equalTo(identityLevelImageView.snp.right).offset(5)
        })
    }
    
}
