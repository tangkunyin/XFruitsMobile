//
//  XFUserCollectionViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/10/5.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import ESPullToRefresh
fileprivate let cellIdentifier = "XFCollectionListCellIdentifier"

class XFUserCollectionViewController: XFBaseSubViewController {

    fileprivate var currentPage: Int = 1
    var collectionData: Array<XFCollectionContent> = []

    fileprivate lazy var collectionListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 166
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.backgroundColor = XFConstants.Color.separatorLine
        tableView.register(XFCollectionListCell.self, forCellReuseIdentifier: cellIdentifier)
        weak var weakSelf = self
        tableView.es.addPullToRefresh(animator: XFRefreshAnimator.header(), handler: {
            weakSelf?.loadcollectionData()
        })
        tableView.es.addInfiniteScrolling(animator: XFRefreshAnimator.footer(), handler: {
            weakSelf?.loadcollectionData(true)
        })
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的收藏"
        renderLoaddingView()
        loadcollectionData()
    }
    
    fileprivate func rendercollectionListView(data: Array<XFCollectionContent>?){
        if let data = data {
            self.collectionData = data
            view.addSubview(collectionListView)
            collectionListView.snp.makeConstraints { (make) in
                make.center.size.equalTo(view)
            }
        }
    }
    
    fileprivate func loadcollectionData(_ loadMore: Bool = false) {
        weak var weakSelf = self
        let params: Dictionary<String, Any> = ["page":currentPage,"size":XFConstants.pageRows]
 
        XFCollectionService.getCollectionList(params: params) { (respData) in
            weakSelf?.collectionListView.es.stopLoadingMore()
            weakSelf?.collectionListView.es.stopPullToRefresh()
            if let collection = respData as? XFCollectionListResult, let collectionList = collection.XFCollectionContent, collectionList.count > 0 {
                weakSelf?.currentPage += 1
                if loadMore {
                    weakSelf?.collectionData += collectionList
                    weakSelf?.rendercollectionListView(data: weakSelf?.collectionData)
                } else {
                    weakSelf?.rendercollectionListView(data: collectionList)
                }
            } else {
                if weakSelf?.currentPage == 1 {
                    weakSelf?.collectionListView.removeFromSuperview()
                    weakSelf?.renderNullDataView()
                } else {
                    weakSelf?.collectionListView.es.noticeNoMoreData()
                }
            }
        }
    }
}

extension XFUserCollectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == collectionData.count - 1 {
//            return 0
//        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == collectionData.count - 1 {
//            return nil
//        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! XFCollectionListCell
//        cell.dataSource = collectionData[indexPath.row]
    //    weak var weakSelf = self
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
 
    }
}


