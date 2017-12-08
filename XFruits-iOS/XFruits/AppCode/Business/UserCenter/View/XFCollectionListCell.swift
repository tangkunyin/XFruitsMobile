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
    
    var dataSource:XFCollectionContent? {
        didSet{
            if let data = dataSource {
                coverImageView.kf.setImage(with: URL(string:data.prodCover), placeholder: UIImage.imageWithNamed(""), options: [.transition(.fade(1))])
                prodNameLabel.text = data.prodName
                prodPrimePrice.text = "￥\(data.prodPrimePrice)"
                prodSpecification.text = data.prodSpecification
                
            }
        }
    }
    
    lazy var coverImageView: UIImageView = {
        let coverImageView = UIImageView.init(image: UIImage.imageWithNamed("defaultAvatar"))
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.masksToBounds = true
        return coverImageView
    }()
    
    lazy var prodNameLabel: UILabel = {
        let prodNameLabel = UILabel.init()
        prodNameLabel.font = XFConstants.Font.pfn14
        prodNameLabel.textColor = UIColor.black
        prodNameLabel.textAlignment = .left
        return prodNameLabel
    }()
    
    lazy var prodSpecification: UILabel = {
        let prodSpecification = UILabel.init()
        prodSpecification.font = XFConstants.Font.pfn14
        prodSpecification.textColor = UIColor.black
        prodSpecification.textAlignment = .left
        return prodSpecification
    }()
    
    lazy var prodPrimePrice: UILabel = {
        let prodPrimePrice = UILabel.init()
        prodPrimePrice.font = XFConstants.Font.pfn18
        prodPrimePrice.textColor = XFConstants.Color.salmon
        prodPrimePrice.textAlignment = .left
        return prodPrimePrice
    }()
    
    fileprivate func customInit(){
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.size.equalTo(80)
        }
        
        contentView.addSubview(prodNameLabel)
        prodNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(coverImageView.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-100)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(prodSpecification)
        prodSpecification.snp.makeConstraints { (make) in
            make.top.equalTo(prodNameLabel.snp.bottom).offset(10)
            make.left.equalTo(prodNameLabel.snp.left)
            make.right.equalTo(contentView.snp.right).offset(-100)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(prodPrimePrice)
        prodPrimePrice.snp.makeConstraints { (make) in
            make.top.equalTo(prodSpecification.snp.bottom).offset(10)
            make.left.equalTo(prodNameLabel.snp.left)
            make.right.equalTo(contentView.snp.right).offset(-100)
            make.height.equalTo(20)
        }
        
    }
}
