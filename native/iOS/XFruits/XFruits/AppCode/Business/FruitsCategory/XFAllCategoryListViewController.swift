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

    var dataSource:Array<ProductType?> = []
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    lazy var tableView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor.white
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "allCategoryListViewCell")
        return listView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有分类"
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
        
        weak var weakSelf = self
        request.getAllCategoryies { (types) in
            if let productTypes = types as? Array<ProductType> {
                weakSelf?.dataSource = productTypes
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCategoryListViewCell", for: indexPath)
        if let category:ProductType = dataSource[indexPath.row] {
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    


}
