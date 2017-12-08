//
//  XFCategoryViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let XFCellViewReuseIdentifier:String = "XFCategoryCellReuseIdentifier"

class XFCategoryViewController: XFBaseViewController {
    
    var currentPage: Int = 1
    
    var dataSource: Array<ProductItem> = []
    var redLayers: Array<CALayer> = []
    
    var dataType: Int = 1001 {
        didSet {
            if dataType != oldValue{
                loadCategories()
            }
        }
    }
    
    var dataSort: Int = 101 {
        didSet {
            weak var weakSelf = self
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                weakSelf?.loadCategories()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
        makeViewConstrains()
        //加载数据
        loadCategories()
    }
    
    func setNavigationBarItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("more-list"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onAllItemClick))
    }
    
    @objc fileprivate func onAllItemClick() {
        let allCateVC = XFAllCategoryListViewController()
        weak var weakSelf = self
        allCateVC.onPageClosed = { (type) in
            weakSelf?.reloadDataView()
            weakSelf?.dataType = type
        }
        present(allCateVC, animated: true, completion: nil)
    }
    
    fileprivate func loadCategories(_ loadMore: Bool = false) {
        weak var weakSelf = self
        let params:XFParams = ["type":dataType,"sort":dataSort,"sequence":1,"page":currentPage,"size":XFConstants.pageRows]
        XFProductService.getAllProducts(params: params) { (data) in
            weakSelf?.removeLoadingView()
            if let cateList = data as? CategoryList, let dataSource = cateList.content {
                weakSelf?.currentPage += 1
                weakSelf?.removeNullDataView()
                if loadMore {
                    weakSelf?.dataSource += dataSource
                    weakSelf?.renderCateListView(data: weakSelf?.dataSource)
                } else {
                    // 重新拉数据
                    weakSelf?.renderCateListView(data: dataSource)
                }
            } else {
                if weakSelf?.currentPage == 1 {
                    weakSelf?.cateListView.alpha = 0
                    weakSelf?.renderNullDataView()
                }
            }
        }
    }
    
    fileprivate func renderCateListView(data: Array<ProductItem>?) {
        if let data = data {
            self.dataSource = data
            self.cateListView.alpha = 1
            self.cateListView.reloadData()
        }
    }
    
    fileprivate func reloadDataView() {
        self.cateListView.alpha = 0
        self.renderLoaddingView()
        self.currentPage = 1
    }
    
    private lazy var headSizer:XFCategoryHeadSizer = {
        let sizer = XFCategoryHeadSizer(textColor: nil, selectTextColor: nil)
        weak var weakSelf = self
        sizer.onSizerChanged = { (sort) in
            weakSelf?.reloadDataView()
            weakSelf?.dataSort = sort
        }
        return sizer;
    }()
    
    private lazy var cateListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let listView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        listView.bounces = true
        listView.delegate = self
        listView.dataSource = self
        listView.collectionViewLayout = layout
        listView.backgroundColor = UIColor.white
        listView.showsVerticalScrollIndicator = false
        listView.showsHorizontalScrollIndicator = false
        listView.register(XFCategoryCell.self, forCellWithReuseIdentifier: XFCellViewReuseIdentifier)
        return listView
    }()
    
    fileprivate func makeViewConstrains(){
        view.addSubview(headSizer)
        view.addSubview(cateListView)
        headSizer.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(44)
            make.left.right.equalTo(view)
        }
        cateListView.snp.makeConstraints { (make) in
            make.top.equalTo(headSizer.snp.bottom).offset(5)
            make.left.right.equalTo(view)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(view)
            }
        }
    }
}

extension XFCategoryViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFCellViewReuseIdentifier, for: indexPath)
        guard let cateCell:XFCategoryCell = cell as? XFCategoryCell  else {
            return cell
        }
        cateCell.dataSource = dataSource[indexPath.row]
        return cateCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: XFConstants.UI.XFHalfCellWidth, height: 226)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = XFDetailViewController()
        let item:ProductItem = dataSource[indexPath.row]
        detail.prodId = item.id
        detail.title = item.name
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
