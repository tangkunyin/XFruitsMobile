//
//  UserCenterCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class UserCenterAvatarCell: UITableViewCell {
  
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    lazy var avatarBtn:UIButton = {
        let avatarBtn = UIButton()
        avatarBtn.setImage(UIImage(named:"apple"), for: .normal)
        return avatarBtn
    }()
    
    lazy var userNameLabel:UILabel = {
        let  userNameLabel = UILabel()
        userNameLabel.text = "zhaojian"
        userNameLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        userNameLabel.font  = UIFont.systemFont(ofSize: 18)
        return userNameLabel
    }()
    
    lazy var identityLevelImageView:UIImageView = {
        let identityLevelImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
        return identityLevelImageView
    }()
    
    
    lazy var  identityDescriptionLabel:UILabel = {
        let identityDescriptionLabel = UILabel.init()
        identityDescriptionLabel.text = "荣耀黄铜v"
        identityDescriptionLabel.textColor = colorWithRGB(83, g: 83, b: 83)
        identityDescriptionLabel.font  = UIFont.systemFont(ofSize: 12)
        return identityDescriptionLabel
    }()
    
    func  setUpUI() {
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        addSubview(avatarBtn)
        avatarBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(10)
            make.height.equalTo(83)
            make.width.equalTo(83)
        })
        
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(avatarBtn.snp.right).offset(0)
 
        })
        
    
        addSubview(identityLevelImageView)
        
        identityLevelImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(15)
            make.left.equalTo(avatarBtn.snp.right).offset(5)
        })
        
      
        addSubview(identityDescriptionLabel)
        
        identityDescriptionLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(identityLevelImageView.snp.right).offset(5)
        })
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
