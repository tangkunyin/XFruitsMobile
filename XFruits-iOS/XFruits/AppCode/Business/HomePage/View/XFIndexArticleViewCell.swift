//
//  XFIndexArticleViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class XFIndexArticleViewCell: UITableViewCell {

    var dataSource: XFNewsContent? {
        didSet {
            if let data = dataSource {
                titleLabel.text = data.title
                detailLabel.text = data.desc
                coverImage.kf.setImage(with: URL.init(string: data.cover),
                                       placeholder: UIImage.imageWithNamed("Loading-white"),
                                       options: [.transition(.flipFromBottom(1))])
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn16
        label.textAlignment = .left
        return label
    }()
    
    private lazy var coverImage: UIImageView = {
        let cover = UIImageView()
        cover.contentMode = .scaleAspectFill
        cover.layer.masksToBounds = true
        return cover
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.coolGrey
        label.font = XFConstants.Font.pfn14
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    
    private func customInit(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(coverImage)
        contentView.addSubview(detailLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(40)
        }
        coverImage.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(228)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(coverImage.snp.bottom).offset(5)
            make.height.equalTo(40)
            make.height.lessThanOrEqualTo(80)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }

}
