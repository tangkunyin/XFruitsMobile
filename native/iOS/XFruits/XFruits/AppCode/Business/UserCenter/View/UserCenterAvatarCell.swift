//
//  UserCenterCell.swift
//  XFruits
//
//  Created by zhaojian on 5/9/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class UserCenterAvatarCell: UITableViewCell {

    var avatarBtn:UIButton?
    var userNameLabel:UILabel?
    var identityLevelImageView:UIImageView?
    var identityDescriptionLabel:UILabel?
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    func  setUpUI() {
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        self.avatarBtn  = UIButton.init()
        self.avatarBtn?.setImage(UIImage(named:"apple"), for: .normal)
        
        self.addSubview(self.avatarBtn!)
        self.avatarBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.height.equalTo(83)
            make.width.equalTo(83)
        })
        
        
        
        self.userNameLabel = UILabel.init()
        self.userNameLabel?.text = "zhaojian"
        self.userNameLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
        self.userNameLabel?.font  = UIFont.systemFont(ofSize: 18)
       
        self.addSubview(self.userNameLabel!)
        
        self.userNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo((self.avatarBtn?.snp.right)!).offset(20)
//            make.height.equalTo(40)
//            make.width.equalTo(40)
        })
        
    
        self.identityLevelImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
        self.addSubview(self.identityLevelImageView!)
        
        self.identityLevelImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.userNameLabel?.snp.bottom)!).offset(10)
            make.left.equalTo((self.avatarBtn?.snp.right)!).offset(20)
            //            make.height.equalTo(40)
            //            make.width.equalTo(40)
        })
        
        
        self.identityDescriptionLabel = UILabel.init()
        self.identityDescriptionLabel?.text = "荣耀黄铜v"
        self.identityDescriptionLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
        self.identityDescriptionLabel?.font  = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(self.identityDescriptionLabel!)
        
        self.identityDescriptionLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.userNameLabel?.snp.bottom)!).offset(10)
            make.left.equalTo((self.identityLevelImageView?.snp.right)!).offset(5)
            //            make.height.equalTo(40)
            //            make.width.equalTo(40)
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
