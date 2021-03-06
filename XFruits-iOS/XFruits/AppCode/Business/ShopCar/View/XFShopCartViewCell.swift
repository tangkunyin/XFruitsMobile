//
//  XFShopCartViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class XFShopCartViewCell: UITableViewCell {
    
    var dataSource:XFCart? {
        didSet {
            if let item = dataSource {
                radioBtn.isSelected = item.selected!
                quantityLabel.text = "\(item.quantity ?? 1)"
                titleLabel.text = item.name
                descLabel.text = "规格：\(item.desc ?? "其他")"
                priceLabel.text = String(format:"¥ %.2f",item.primePrice!)
                thumbnail.kf.setImage(with: URL.init(string: item.cover!),
                                      placeholder: UIImage.imageWithNamed("Loading-squre-transparent"),
                                      options: [.transition(.fade(0.8))])
            }
        }
    }
    

    lazy var radioBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_uncheck"), for: .normal)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_check"), for: .selected)
        btn.addTarget(self, action: #selector(selectChanged(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var plusBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.tag = 1
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.setTitleColor(grayColor(200), for: .disabled)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.addTarget(self, action: #selector(quantityChanged(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var minusBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.tag = -1
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.setTitleColor(grayColor(200), for: .disabled)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.addTarget(self, action: #selector(quantityChanged(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
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
    
    lazy var descLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var priceLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var quantityLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .center
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = false
        title.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        title.layer.borderColor = XFConstants.Color.darkGray.cgColor
        title.text = "0"
        return title
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    
    @objc fileprivate func selectChanged(btn:UIButton) {
        if XFCartUtils.sharedInstance.selectItem(gid: dataSource!.id!, checked: !btn.isSelected) {
            btn.isSelected = !btn.isSelected
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: XFConstants.MessageKey.NeedRefreshShopCartData), object: nil)
        }
    }
    
    @objc fileprivate func quantityChanged(btn:UIButton) {
        if var quantity:Int = Int(quantityLabel.text!) {
            switch btn.tag {
            case -1:
                quantity -= 1
            case 1:
                quantity += 1
            default:
                quantity = 0
                break
            }
            guard quantity > 0 else {
                return
            }
            if XFCartUtils.sharedInstance.changeCount(gid: dataSource!.id!, count: quantity) {
                quantityLabel.text = "\(quantity)"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: XFConstants.MessageKey.NeedRefreshShopCartData), object: nil)
            }
        }
    }
    
    // MARK: - make constrains
    func customInit(){
        
        addSubview(radioBtn)
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(priceLabel)
        addSubview(minusBtn)
        addSubview(quantityLabel)
        addSubview(plusBtn)
        
        radioBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.size.equalTo(16)
            make.left.equalTo(self.snp.left).offset(10)
        }
        thumbnail.snp.makeConstraints { (make) in
            make.size.equalTo(90)
            make.left.equalTo(self.radioBtn.snp.right).offset(10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(25)
            make.top.equalTo(self.thumbnail.snp.top).offset(5)
            make.bottom.equalTo(self.descLabel.snp.top)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.height.equalTo(25)
            make.right.equalTo(self.minusBtn.snp.left)
            make.bottom.equalTo(self.thumbnail.snp.bottom).offset(0)
        }
        minusBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 35, height: 25))
            make.left.equalTo(self.priceLabel.snp.right)
            make.right.equalTo(self.quantityLabel.snp.left)
            make.bottom.equalTo(self.priceLabel.snp.bottom).offset(0)
        }
        quantityLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 25))
            make.left.equalTo(self.minusBtn.snp.right)
            make.right.equalTo(self.plusBtn.snp.left)
            make.bottom.equalTo(self.minusBtn.snp.bottom)
        }
        plusBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 35, height: 25))
            make.left.equalTo(self.quantityLabel.snp.right)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self.quantityLabel.snp.bottom)
        }
    }
}
