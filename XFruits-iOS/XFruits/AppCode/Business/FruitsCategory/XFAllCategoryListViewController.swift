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
    
    var selectedTypeId: Int = 1000
    
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
        listView.separatorColor = XFConstants.Color.separatorLine
        listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        listView.backgroundColor = UIColor.white
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "allCategoryListViewCell")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCategoryListViewCell", for: indexPath)
        let category:ProductType = productTypes[indexPath.row]
        let imageView:UIImageView = UIImageView()
        imageView.kf.setImage(with: URL.init(string: category.image))
        let label:UILabel = UILabel()
        label.text = category.name
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(label)
        imageView.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize.init(width: 35, height: 35))
            make.left.equalTo(cell.contentView).offset(10)
            make.centerY.equalTo(cell.contentView)
        })
        label.snp.makeConstraints({ (make) in
            make.size.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(10)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: ProductType = productTypes[indexPath.row]
        self.selectedTypeId = type.id
        self.slideMenuController()?.closeRight()
    }
}
