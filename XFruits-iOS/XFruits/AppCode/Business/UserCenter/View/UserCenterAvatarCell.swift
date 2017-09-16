//
//  UserCenterCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class UserCenterAvatarCell: UITableViewCell {
  
    var user: XFUser? {
        didSet{
            if let user = user {
                userNameLabel.text = user.username
                identityDescriptionLabel.text = "帅帅的荣耀会员"
            }
        }
    }
    
    lazy var avatarBtn:UIButton = {
        let avatarBtn = UIButton()
        avatarBtn.setImage(UIImage(named:"defaultAvatar"), for: .normal)
        avatarBtn.layer.cornerRadius = 35
        avatarBtn.layer.masksToBounds = true
        return avatarBtn
    }()
    
    lazy var userNameLabel:UILabel = {
        let  userNameLabel = UILabel()
        userNameLabel.text = "那个，请先登录"
        userNameLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        userNameLabel.font  = XFConstants.Font.pfn16
        return userNameLabel
    }()
    
    lazy var identityLevelImageView:UIImageView = {
        let identityLevelImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
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
        addSubview(avatarBtn)
        
        avatarBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(snp.left).offset(10)
            make.width.height.equalTo(70)
            make.centerY.equalTo(self).offset(5)
        })
    
        userNameLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self).offset(-8)
            make.left.equalTo(avatarBtn.snp.right).offset(15)
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
