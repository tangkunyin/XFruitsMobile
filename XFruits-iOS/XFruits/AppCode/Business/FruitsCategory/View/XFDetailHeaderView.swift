//
//  XFDetailHeaderView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

/// 详情页首部商品介绍、幻灯片
class XFDetailHeaderView: UIView {

    var dataSource:ProductDetail? {
        didSet {
            detailViewPager.dataSource = dataSource!.cover
            titleLabel.text = dataSource!.name
            priceLabel.text = String(format:"¥ %.2f",dataSource!.primePrice)
            specificationDescLabel.text = "规格：\(dataSource!.specification)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    lazy var detailViewPager: XFViewPager = {
        let pager = XFViewPager.init(placeHolder: "Loading-white")
        return pager
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn18
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        return label
    }()
    
    lazy var specificationDescLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "服务："
        return label
    }()
    
    lazy var serviceDescriptions: UIView = {
        let view:UIView = UIView()
        let baoyou = serviceTagView(withTitle: "包邮", imageName: "service_you")
        let posun = serviceTagView(withTitle: "破损补寄", imageName: "service_bu")
        let fahuo = serviceTagView(withTitle: "按时发货", imageName: "service_fahuo")
        let shouhou = serviceTagView(withTitle: "售后无忧", imageName: "service_shouhou")
        let tuikuan = serviceTagView(withTitle: "极速退款", imageName: "service_shantui")
        view.addSubview(baoyou)
        view.addSubview(posun)
        view.addSubview(fahuo)
        view.addSubview(shouhou)
        view.addSubview(tuikuan)
        baoyou.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(posun.snp.width)
            make.width.equalTo(fahuo.snp.width)
            make.left.top.equalTo(view)
            make.right.equalTo(posun.snp.left)
        }
        posun.snp.makeConstraints { (make) in
            make.height.equalTo(baoyou)
            make.width.equalTo(baoyou.snp.width)
            make.width.equalTo(fahuo.snp.width)
            make.left.equalTo(baoyou.snp.right)
            make.right.equalTo(fahuo.snp.left)
            make.bottom.equalTo(baoyou)
        }
        fahuo.snp.makeConstraints { (make) in
            make.height.equalTo(baoyou)
            make.width.equalTo(posun.snp.width)
            make.width.equalTo(baoyou.snp.width)
            make.left.equalTo(posun.snp.right)
            make.right.equalTo(view)
            make.bottom.equalTo(baoyou)
        }
        shouhou.snp.makeConstraints { (make) in
            make.height.equalTo(baoyou)
            make.width.equalTo(baoyou.snp.width)
            make.left.bottom.equalTo(view)
            make.top.equalTo(baoyou.snp.bottom).offset(10)
            make.right.equalTo(tuikuan.snp.left)
        }
        tuikuan.snp.makeConstraints { (make) in
            make.height.equalTo(baoyou)
            make.width.equalTo(baoyou.snp.width)
            make.top.equalTo(shouhou)
            make.left.equalTo(shouhou.snp.right)
            make.bottom.equalTo(shouhou)
        }
        return view
    }()
    
    fileprivate func customInit(){
        backgroundColor = UIColor.white
        
        let specificationDescLabelTopLine:UIView = createSeperateLine()
        let specificationDescLabelBottomLine:UIView = createSeperateLine()
        
        addSubview(detailViewPager)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        addSubview(specificationDescLabelTopLine)
        addSubview(specificationDescLabel)
        addSubview(specificationDescLabelBottomLine)
        
        addSubview(serviceTitleLabel)
        addSubview(serviceDescriptions)
        
        detailViewPager.snp.makeConstraints { (make) in
            make.top.width.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp.top)
            // 提前约定好宽高比，搞成正方形，高度与屏宽一致
            make.height.equalTo(floor(XFConstants.UI.deviceWidth/(900/900)))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(35)
            make.top.equalTo(self.detailViewPager.snp.bottom)
            make.bottom.equalTo(self.priceLabel.snp.top)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(25)
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.bottom.equalTo(specificationDescLabelTopLine.snp.top)
        }
        specificationDescLabelTopLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.4)
            make.bottom.equalTo(self.specificationDescLabel.snp.top)
        }
        specificationDescLabel.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(specificationDescLabelTopLine.snp.bottom)
            make.bottom.equalTo(specificationDescLabelBottomLine.snp.top)
        }
        specificationDescLabelBottomLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.4)
        }
        serviceTitleLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 30))
            make.left.equalTo(self).offset(10)
            make.top.equalTo(specificationDescLabelBottomLine.snp.bottom).offset(8)
            make.right.equalTo(self.serviceDescriptions.snp.left)
        }
        serviceDescriptions.snp.makeConstraints { (make) in
            make.left.equalTo(self.serviceTitleLabel.snp.right)
            make.top.equalTo(self.serviceTitleLabel.snp.top)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    private func serviceTagView(withTitle title:String,imageName:String) -> UIView {
        let tagView = UIView()
        let tagIconView = UIImageView(image: UIImage.imageWithNamed(imageName))
        let tagTextView = UILabel()
        tagTextView.text = title
        tagTextView.textColor = XFConstants.Color.darkGray
        tagTextView.textAlignment = .left
        tagTextView.adjustsFontSizeToFitWidth = false
        tagTextView.font = XFConstants.Font.pfn12
        tagView.addSubview(tagIconView)
        tagView.addSubview(tagTextView)
        tagIconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 27, height: 27))
            make.centerY.left.equalToSuperview()
        }
        tagTextView.snp.makeConstraints { (make) in
            make.left.equalTo(tagIconView.snp.right).offset(5)
            make.top.bottom.right.equalToSuperview()
        }
        return tagView
    }
    
}
