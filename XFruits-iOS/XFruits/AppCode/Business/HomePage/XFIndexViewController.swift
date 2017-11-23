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
    var player:XLVideoPlayer!
    
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.destroy()
        player = nil
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
        detail.title = "详情"
        navigationController?.pushViewController(detail, animated: true)
    }
    
    fileprivate func handlePagerClick(withIndex index: Int) {
        if let loopImages = loopImages {
            let pager: XFIndexLoopImage = loopImages[index]
            switch pager.type {
            case XFIndexConentType.html.rawValue,
                 XFIndexConentType.advertising.rawValue:
                jumpToWebview(url: loopImages[index].data, title: loopImages[index].title)
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
                jumpToWebview(url: data.data, title: data.title)
            case XFIndexConentType.product.rawValue:
                jumpToProductDetail(pId: data.data)
            case XFIndexConentType.video.rawValue:
                break
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
    
    fileprivate lazy var indexHeaderView: UIView = {
        let view = UIView()
        let seperator = XFSeperatorView()
        seperator.backgroundColor = XFConstants.Color.white
        view.addSubview(pagerView)
        view.addSubview(seperator)
        pagerView.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(loopImageComponentHeight)
        })
        seperator.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(60)
        })
        return view
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
    
    @objc func showVideoPlayer(tapGesture:UITapGestureRecognizer)  {
        player?.destroy()
        player = nil
        let tapView = tapGesture.view
        let indexPath:IndexPath  = IndexPath.init(row: (tapView?.tag)! - 100, section: 0)  
        
        let cell:XFIndexArticleViewCell = articleListView.cellForRow(at: indexPath) as! XFIndexArticleViewCell
        player = XLVideoPlayer.init()
        
        player?.videoUrl = dataSource[indexPath.row].data
        player?.playerBindTableView(articleListView, currentIndexPath: indexPath)
        player?.frame = CGRect(x:0,y:55,width:XFConstants.UI.deviceWidth,height:228)
        
        cell.contentView.addSubview(player!)

        weak var weakSelf = self

        player.completedPlayingBlock = {(player1) -> Void in
            player1?.destroy()
            weakSelf?.player = nil
        }
     }
}

extension XFIndexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! XFIndexArticleViewCell
        cell.selectionStyle = .none
        cell.dataSource = dataSource[indexPath.row]
        if cell.dataSource?.type == 3 {
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(showVideoPlayer))
            cell.coverImage.addGestureRecognizer(tap)
        }
        cell.coverImage.tag = 100 + indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return loopImageComponentHeight + 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return indexHeaderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleItemClick(withData: dataSource[indexPath.row])
    }
    
}

