//
//  XFCategoryViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import ESPullToRefresh

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
            loadCategories()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNavigationBarItem()
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
            weakSelf?.cateListView.es.stopLoadingMore()
            weakSelf?.cateListView.es.stopPullToRefresh()
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
                } else {
                    weakSelf?.cateListView.es.noticeNoMoreData()
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
        listView.delegate = self
        listView.dataSource = self
        listView.collectionViewLayout = layout
        
        listView.backgroundColor = UIColor.white
        listView.register(XFCategoryCell.self, forCellWithReuseIdentifier: XFCellViewReuseIdentifier)
        // 下拉刷新
        weak var weakSelf = self
        listView.es.addPullToRefresh(animator: XFRefreshAnimator.header(), handler: {
            weakSelf?.loadCategories()
        })
        // 上拉分页
        listView.es.addInfiniteScrolling(animator: XFRefreshAnimator.footer(), handler: {
            weakSelf?.loadCategories(true)
        })
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
    //  把该端抽象出来 todo
    func initCHLayerFromPoint (imageView:UIImageView,  startPoint:CGPoint,endPoint:CGPoint)   {
        let chLayer  =    CALayer.init()
        chLayer.frame = CGRect(x:startPoint.x,y:startPoint.y,width:40,height:40)
        chLayer.contents = imageView.layer.contents
        chLayer.cornerRadius = 15/2
        
        var rootVC: UIViewController = (UIApplication.shared.delegate?.window!!.rootViewController)!!
        while rootVC.isKind(of: UINavigationController.self) {
            rootVC = (rootVC as? UINavigationController)!.topViewController!
        }
        redLayers.append(chLayer)
       rootVC.view.layer.addSublayer(chLayer)
        
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, control: CGPoint(x:endPoint.x,y:startPoint.y))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.rotationMode = kCAAnimationRotateAuto
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.duration = 0.5
        expandAnimation.fromValue = 1
        expandAnimation.toValue = 1.5
        expandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let narrowAnimation = CABasicAnimation(keyPath: "transform.scale")
        narrowAnimation.beginTime = 0.5
        narrowAnimation.fromValue = 1.5
        narrowAnimation.duration = 1.5
        narrowAnimation.toValue = 0.5
        narrowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let groups:CAAnimationGroup = CAAnimationGroup()
        groups.duration = 2
        groups.delegate = self
        groups.animations = [animation, expandAnimation, narrowAnimation]
        groups.isRemovedOnCompletion = false
        chLayer.add(groups, forKey: "groups")
    }
}

extension XFCategoryViewController:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        let tabView:UIView  = (self.tabBarController?.tabBar.subviews[3])!
        let shakeAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        shakeAnimation.duration = 0.25
        shakeAnimation.fromValue = NSNumber.init(value: -5)
        shakeAnimation.toValue = NSNumber.init(value: 5)
        shakeAnimation.autoreverses = true
        tabView.layer.add(shakeAnimation, forKey: nil)
        redLayers[0].removeFromSuperlayer()
        redLayers.removeAll()
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.25f;
//        _badgeLabel.text = [NSString stringWithFormat:@"%ld",_badgeNum];
//        [_badgeLabel.layer addAnimation:animation forKey:nil];
 
    }
}

extension XFCategoryViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var weakSelf = self

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XFCellViewReuseIdentifier, for: indexPath)
        guard let cateCell:XFCategoryCell = cell as? XFCategoryCell  else {
            return cell
        }
        cateCell.dataSource = dataSource[indexPath.row]
 
        cateCell.myClosure = { () -> Void in
            let startPoint  =  weakSelf?.view.convert(cateCell.center, from: self.view)
            let endPoint = CGPoint(x: XFConstants.UI.deviceWidth / 4 * 3 - 40 , y: XFConstants.UI.deviceHeight - 30)
            weakSelf?.initCHLayerFromPoint(imageView:cateCell.thumbnail, startPoint: startPoint!, endPoint: endPoint)

        }
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
