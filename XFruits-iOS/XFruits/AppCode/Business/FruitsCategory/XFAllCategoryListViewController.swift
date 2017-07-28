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


class XFAllCategoryListViewController: XFBaseSubViewController,UITableViewDelegate,UITableViewDataSource {

    private var productTypes :Array<ProductType> = []
    
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
    
    lazy var tableView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor.white
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "allCategoryListViewCell")
        listView.tableFooterView = UIView()
        return listView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有"
        
        dPrint(productTypes)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
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
            make.size.equalTo(CGSize.init(width: 55, height: 55))
            make.left.top.equalTo(10)
        })
        label.snp.makeConstraints({ (make) in
            make.size.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(20)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    


}
