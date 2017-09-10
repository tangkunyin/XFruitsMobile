//
//  XFIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellIdentifier = "XFIndexArticleCellIdentifier"

// 约定好宽高比
fileprivate let loopImageComponentHeight = floor(XFConstants.UI.deviceWidth/(1920/1080))

class XFIndexViewController: XFBaseViewController {
    
    var loopImages: Array<XFIndexLoopImage>? {
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
    
    var dataSource: Array<XFNewsContent> = [] {
        didSet {
            articleListView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if XFDataGlobal.shared.isTheFirstOpenApp() {
            weak var weakSelf = self
            present(XFAppGuideViewController(), animated: false) {
                weakSelf?.renderHomeIndexView()
            }
        } else {
            renderHomeIndexView()
        }
    }
    
    fileprivate func renderHomeIndexView() {
        view.addSubview(articleListView)
        articleListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
        loadData()
    }
    
    fileprivate func loadData(){
        weak var weakSelf = self
        XFNewsInfoService.getLoopImages { (result) in
            weakSelf?.loopImages = result as? Array
        }
        XFNewsInfoService.getNewsList(params: ["page":1,"size":XFConstants.pageRows]) { (respData) in
            if let newsInfo = respData as? XFNewsInfo,
                let content = newsInfo.content, content.count > 0 {
                weakSelf?.dataSource = content
            }
        }
    }
    
    // 统一跳网页
    fileprivate func jumpToWebview(url: String, title: String = "拾个鲜果"){
        let webView = XFWebViewController.init(withUrl: url)
        webView.title = title
        navigationController?.pushViewController(webView, animated: true)
    }
    
    // 跳详情页
    fileprivate func jumpToProductDetail(pId: String){
        let detail = XFDetailViewController()
        detail.prodId = pId
        navigationController?.pushViewController(detail, animated: true)
    }
    
    fileprivate func handlePagerClick(withIndex index: Int) {
        if let loopImages = loopImages {
            let pager: XFIndexLoopImage = loopImages[index]
            switch pager.type {
            case XFIndexConentType.html.rawValue,
                 XFIndexConentType.advertising.rawValue:
                jumpToWebview(url: loopImages[index].data)
            case XFIndexConentType.product.rawValue:
                jumpToProductDetail(pId: loopImages[index].data)
            default:
                break
            }
        }
        
    }
    
    fileprivate func handleItemClick(withData data: XFNewsContent) {
        switch data.type {
        case XFIndexConentType.html.rawValue,
             XFIndexConentType.advertising.rawValue:
            jumpToWebview(url: data.data)
        case XFIndexConentType.product.rawValue:
            jumpToProductDetail(pId: data.data)
        default:
            break
        }
    }
    
    fileprivate lazy var pagerView:XFViewPager = {
        let pagerView = XFViewPager(source: [""], placeHolder: "Loading-white")
        weak var weakSelf = self
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            weakSelf?.handlePagerClick(withIndex: index)
        }
        return pagerView
    }()
    
    fileprivate lazy var articleListView: UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .grouped)
        listView.delegate = self
        listView.dataSource = self
        listView.showsVerticalScrollIndicator = false
        listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        listView.separatorColor = XFConstants.Color.separatorLine
        listView.rowHeight = UITableViewAutomaticDimension
        listView.estimatedRowHeight = 360
        listView.register(XFIndexArticleViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return listView
    }()

}

extension XFIndexViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleItemClick(withData: dataSource[indexPath.row])
    }
    
}

