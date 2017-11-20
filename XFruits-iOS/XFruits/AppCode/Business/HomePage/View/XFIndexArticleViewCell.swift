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
import MediaPlayer
import AVKit

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
    
      lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn16
        label.textAlignment = .left
        return label
    }()
    
      lazy var coverImage: UIImageView = {
        let cover = UIImageView()
        cover.contentMode = .scaleAspectFill
        cover.layer.masksToBounds = true
        cover.isUserInteractionEnabled = true
        return cover
    }()
    
//      lazy var playerView:XLVideoPlayer = {
//        let player = XLVideoPlayer.init()
//        player.videoUrl = ""
//      
//        return player
//    }()
    
      lazy var pauseImageView:UIImageView = {
       let imageView = UIImageView.init(image: UIImage.imageWithNamed("play"))
        return imageView
    }()
    
      lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn14
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    
    fileprivate func customInit(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(coverImage)
//        contentView.addSubview(playerView)
        contentView.addSubview(detailLabel)
        contentView.addSubview(pauseImageView)
        
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
//        playerView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(titleLabel)
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.height.equalTo(228)
//        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(coverImage.snp.bottom).offset(5)
            make.height.equalTo(40)
            make.height.lessThanOrEqualTo(80)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        pauseImageView.snp.makeConstraints { (make ) in
            make.center.equalTo(contentView)
            make.size.equalTo(50)
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
