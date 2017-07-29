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
            priceLabel.text = String(format:"%.2f",dataSource!.salesPrice)
            specificationDescLabel.text = dataSource!.specification
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
        let pager = XFViewPager.init(placeHolder: "default-apple")
        return pager
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn18
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .center
        label.text = "拾个鲜果圣诞果一箱6个"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        label.text = "¥ 39.00"
        return label
    }()
    
    lazy var specificationDescLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "规格： 一箱6个、直径85mm"
        return label
    }()
    
    lazy var serviceTitleLabel: UILabel = {
        let label = UILabel();
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "服务："
        return label
    }()
    
    lazy var serviceDescriptions: UIView = {
        let view:UIView = UIView();
        let baoyou:UIButton = self.btnWithTitle("包邮", imageName: "service_you")
        let posun:UIButton = self.btnWithTitle("破损补寄", imageName: "service_bu")
        let fahuo:UIButton = self.btnWithTitle("按时发货", imageName: "service_fahuo")
        let shouhou:UIButton = self.btnWithTitle("售后无忧", imageName: "service_shouhou")
        let tuikuan:UIButton = self.btnWithTitle("极速退款", imageName: "service_tui")
        view.addSubview(baoyou)
        view.addSubview(posun)
        view.addSubview(fahuo)
        view.addSubview(shouhou)
        view.addSubview(tuikuan)
        
        baoyou.snp.makeConstraints { (make) in
            make.height.equalTo(26)
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
    
    private func customInit(){
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
            // TODO: 提前约定好宽高比
            make.height.equalTo(floor(XFConstants.UI.deviceWidth/(1200/900)))
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
            make.bottom.equalTo(self.serviceTitleLabel.snp.top)
        }
        serviceTitleLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 44, height: 26))
            make.left.equalTo(self).offset(10)
            make.top.equalTo(specificationDescLabelBottomLine.snp.bottom)
            make.right.equalTo(self.serviceDescriptions.snp.left)
        }
        serviceDescriptions.snp.makeConstraints { (make) in
            make.height.equalTo(62)
            make.left.equalTo(self.serviceTitleLabel.snp.right)
            make.top.equalTo(self.serviceTitleLabel.snp.top)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
    func btnWithTitle(_ title:String,imageName:String) -> UIButton {
        let btn = UIButton.buttonWithTitle(title,
                                           image: imageName,
                                           textColor: XFConstants.Color.darkGray,
                                           textFont: XFConstants.Font.pfn12,
                                           directionType: .left,
                                           chAlignment: .left,
                                           cvAlignment: .center,
                                           cEdgeInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0),
                                           span: 6,
                                           target: nil,
                                           action: nil)
        return btn
    }
    
}
