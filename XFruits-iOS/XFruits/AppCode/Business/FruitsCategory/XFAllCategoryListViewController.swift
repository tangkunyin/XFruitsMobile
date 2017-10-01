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

fileprivate let XFAllCateListCellReuseIdentifier:String = "XFAllCateListCellReuseIdentifier"

class XFAllCategoryListViewController: XFBaseViewController {

    var onPageClosed: ((Int)->Void)?
    
    var productTypes: Array<ProductType> = []
    
    var dataSource:Array<ProductType>? {
        get {
            return productTypes
        }
        set {
            if let datasource = newValue {
                productTypes = datasource
                cateListView.reloadData()
            }
        }
    }
    
    lazy var cateListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let listView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        listView.delegate = self
        listView.dataSource = self
        listView.collectionViewLayout = layout
        listView.backgroundColor = UIColor.white
        listView.register(CategoryCellView.self, forCellWithReuseIdentifier: XFAllCateListCellReuseIdentifier)
        return listView
    }()
    
    fileprivate lazy var dismissBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("dialog_close"), for: .normal)
        btn.addTarget(self, action: #selector(onPageCloseClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cateListView)
        view.addSubview(dismissBtn)
        cateListView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(dismissBtn.snp.top).offset(-10)
        }
        dismissBtn.snp.makeConstraints { (make) in
            make.size.equalTo(24)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-45)
        }

        loadData()
    }
    
    fileprivate func loadData() {
        weak var weakSelf = self
        // 拉取所有分类数据
        XFProductService.getAllCategoryies { (types) in
            if let productTypes = types as? Array<ProductType> {
                weakSelf?.dataSource = productTypes
            }
        }
    }
    
    @objc fileprivate func onPageCloseClick() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension XFAllCategoryListViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFAllCateListCellReuseIdentifier, for: indexPath)
        guard let cateCell:CategoryCellView = cell as? CategoryCellView  else {
            return cell
        }
        cateCell.dataSource = productTypes[indexPath.row]
        return cateCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: XFConstants.UI.XFHalfCellWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type: ProductType = productTypes[indexPath.row]
        weak var weakSelf = self
        dismiss(animated: true) {
            if let action = weakSelf?.onPageClosed {
                action(type.id)
            }
        }
    }
    
}

fileprivate class CategoryCellView: UICollectionViewCell {
    
    var dataSource: ProductType? {
        didSet{
            if let data = dataSource {
                iconImageView.kf.setImage(with: URL(string: data.image))  
                categoryTitle.text = data.name
            }
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.imageWithNamed("logo"))
        return imageView
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn14
        label.textAlignment = .center
        return label
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(categoryTitle)
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 65, height: 65))
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
        }
        categoryTitle.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
    }
    
    
}
