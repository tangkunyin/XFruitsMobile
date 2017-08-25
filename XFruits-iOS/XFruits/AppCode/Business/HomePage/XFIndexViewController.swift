//
//  XFIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

fileprivate let cellIdentifier = "XFIndexArticleCellIdentifier"

// 约定好宽高比
fileprivate let loopImageComponentHeight = floor(XFConstants.UI.deviceWidth/(1920/1080))

class XFIndexViewController: XFBaseViewController {
    
    private var loopImages: Array<XFIndexLoopImage>? {
        didSet {
            if let images = loopImages {
                var imageUrls: Array<String> = []
                for item in images {
                    imageUrls.append(item.cover)
                }
                if imageUrls.count > 0 {
                    pagerView.dataSource = imageUrls
                }
            }
        }
    }
    
    private var dataSource: Array<XFNewsContent> = [] {
        didSet {
            articleListView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(articleListView)
        articleListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
     
        loadData()
    }
    
    private func loadData(){
        weak var weakSelf = self
        request.getLoopImages { (result) in
            weakSelf?.loopImages = result as? Array
        }
        request.getNewsList(params: ["page":1,"size":XFConstants.pageRows]) { (respData) in
            if let newsInfo = respData as? XFNewsInfo,
                let content = newsInfo.content, content.count > 0 {
                weakSelf?.dataSource = content
            }
        }
    }

    
    private lazy var request: XFNewsInfoService = {
        return XFNewsInfoService()
    }()
    
    private lazy var pagerView:XFViewPager = {
        let pagerView = XFViewPager(source: [""], placeHolder: "Loading-white")
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            dPrint("\(index) 号被点击")
        }
        return pagerView
    }()
    
    lazy var articleListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 360
        tableView.register(XFIndexArticleViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()

}

extension XFIndexViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! XFIndexArticleViewCell
        cell.selectionStyle = .none
        cell.dataSource = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return loopImageComponentHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return pagerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
    }
    
}

