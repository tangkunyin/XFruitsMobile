//
//  XFAllCategoryListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class XFAllCategoryListViewController: XFBaseSubViewController {

    var productTypes :Array<ProductType> = []
    
    var selectedTypeId: Int = 1001
    
    var dataSource:Array<ProductType>? {
        get {
            return productTypes
        }
        set {
            if let datasource = newValue {
                productTypes = datasource
                tableView.reloadData()
            }
        }
    }
    
    lazy var promotionView: UIImageView = {
        let imageView = UIImageView(image: UIImage.imageWithNamed("xfruits-farmer-4"))
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let listView = UITableView(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.bounces = false
        listView.rowHeight = 44
        listView.separatorColor = XFConstants.Color.separatorLine
        listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        listView.backgroundColor = UIColor.white
        listView.register(CategoryCellView.self, forCellReuseIdentifier: "allCategoryListViewCell")
        listView.tableFooterView = UIView()
        return listView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(promotionView)
        view.addSubview(tableView)
        promotionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(100)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(promotionView.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view)
        }
    }
    
}

extension XFAllCategoryListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCategoryListViewCell") as! CategoryCellView
        let type = productTypes[indexPath.row]
        cell.isSelected = type.id == selectedTypeId
        cell.dataSource = type
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: ProductType = productTypes[indexPath.row]
        self.selectedTypeId = type.id
        self.slideMenuController()?.closeRight()
        tableView.reloadData()
    }
}

fileprivate class CategoryCellView: UITableViewCell {
    
    var dataSource: ProductType? {
        didSet{
            if let data = dataSource {
                iconImageView.kf.setImage(with: URL(string: data.image))
                categoryTitle.text = data.name
                customAccessoryView.isHidden = !isSelected
            }
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.imageWithNamed("logo"))
        return imageView
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var customAccessoryView: UIImageView = {
        let imageView = UIImageView(image: UIImage.imageWithNamed("success_big"))
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit(){
        selectionStyle = .none
        contentView.addSubview(iconImageView)
        contentView.addSubview(categoryTitle)
        contentView.addSubview(customAccessoryView)
        iconImageView.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 35, height: 35))
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
            
        })
        categoryTitle.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(customAccessoryView.snp.left).offset(-10)
        })
        customAccessoryView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 18, height: 18))
            make.right.equalTo(contentView).offset(-10)
        }
    }
}
