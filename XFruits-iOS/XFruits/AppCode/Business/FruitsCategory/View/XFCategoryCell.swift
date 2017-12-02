
//
//  XFCategoryCell.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import MBProgressHUD


class XFCategoryCell: UICollectionViewCell {
 
    var imgViewHeightConstraint: Constraint?
    var dataSource:ProductItem? {
        didSet {
            if let item = dataSource {
                titleLabel.text = item.name
                priceLabel.text = String(format:"¥ %.2f",item.primePrice)
                thumbnail.kf.setImage(with: URL.init(string: item.cover),
                                      placeholder: UIImage.imageWithNamed("Loading-squre-white"),
                                      options: [.transition(.flipFromTop(0.8))])
            }
        }
    }
    
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("Loading-squre-transparent"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var priceLabel:UILabel = {
        let price = UILabel()
        price.textColor = XFConstants.Color.salmon
        price.font = XFConstants.Font.pfn14
        price.textAlignment = .left
        price.adjustsFontSizeToFitWidth = false
        price.lineBreakMode = .byTruncatingTail
        return price
    }()
    
    
    lazy var cartBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.imageWithNamed("shopCart-icon"), for: .normal)
        btn.addTarget(self, action: #selector(addToCartFromCategoryItem), for: .touchUpInside)
        return btn
    }()
    

    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    fileprivate func customInit(){
        
        layer.borderWidth = 1
        layer.borderColor = XFConstants.Color.commonBackground.cgColor
        
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(cartBtn)
        
        makeCellConstrains()
    }
    
    fileprivate func makeCellConstrains(){
        thumbnail.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp.top)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(self.thumbnail.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self.priceLabel.snp.top)
            make.bottom.equalTo(self.cartBtn.snp.top)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(30)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self.cartBtn.snp.left)
            make.bottom.equalTo(self).offset(0)
        }
        cartBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.size.equalTo(30)
            make.left.equalTo(self.priceLabel.snp.right)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    @objc fileprivate func addToCartFromCategoryItem(){
        weak var weakSelf = self

        if let item: ProductItem = dataSource {
            let result = XFCartUtils.sharedInstance.addItem(item: item)
            if result {
                MBProgressHUD.showSuccess("成功添加到果篮")
                let animationToolUtil = XFAddToCartAnimationTool.shared
                
                let startPoint  = CGPoint(x:self.frame.origin.x + self.frame.size.width/2,y:self.frame.origin.y + self.frame.size.height)  // 这里我也不知道为啥不除以2啊
                
                let endPoint = CGPoint(x: XFConstants.UI.deviceWidth / 4 * 3 - 40 , y: XFConstants.UI.deviceHeight - 30)
                animationToolUtil.startAnimation(view: (weakSelf?.thumbnail)!, startPoint: startPoint, endPoint: endPoint, andFinishBlock: { (finished) in
                    if finished == true{
                        let tabbarVC:XFHomeViewController = UIApplication.shared.keyWindow?.rootViewController as! XFHomeViewController
                        let tabView = tabbarVC.tabBar.subviews[3]
                        animationToolUtil.shakeAnimation(shakeView: tabView)
                    }
                })
            } else {
                MBProgressHUD.showError("添加到果篮失败，请稍后尝试~")
            }
        }
    }

}
