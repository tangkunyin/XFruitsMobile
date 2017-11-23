//
//  XFCollectionListCell.swift
//  XFruits
//
//  Created by 赵健 on 23/11/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher



class XFCollectionListCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    
    lazy var coverImageView: UIImageView = {
        let coverImageView = UIImageView.init(image: UIImage.imageWithNamed("defaultAvatar"))
        
        coverImageView.layer.cornerRadius = 35
        coverImageView.layer.masksToBounds = true
        return coverImageView
    }()
    
    fileprivate func customInit(){
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.size.equalTo(80)
        }
        
    }
    
}
