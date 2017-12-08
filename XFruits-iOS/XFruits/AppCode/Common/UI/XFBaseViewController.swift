//
//  XFBaseViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /// 私有公共组件
    fileprivate lazy var loaddingView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("Loading-squre-transparent"))
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var nullDataView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("xfruits-farmer-3"))
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var nullDataTip: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn16
        label.textAlignment = .center
        label.textColor = XFConstants.Color.tipTextGrey
        label.text = "报告老板，暂未发现目标，请稍后再试~"
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bigTitle(forNavBar: navigationController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let transition = CATransition()
        transition.type = "rippleEffect"
        transition.duration = 1.0
        view.layer.add(transition, forKey: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = XFConstants.Color.commonBackground
    
        // 打开自带的边缘侧滑返回
        weak var weakSelf = self
        navigationController?.interactivePopGestureRecognizer?.delegate = weakSelf
    }
    
    func renderLoaddingView(){
        removeNullDataView()
        view.addSubview(loaddingView)
        loaddingView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize.init(width: 240, height: 240))
        }
    }
    
    func renderNullDataView(){
        removeLoadingView()
        view.addSubview(nullDataView)
        view.addSubview(nullDataTip)
        nullDataView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(135)
            make.size.equalTo(CGSize(width: 240, height: 227))
        }
        nullDataTip.snp.makeConstraints { (make) in
            make.top.equalTo(nullDataView.snp.bottom).offset(10)
            make.centerX.equalTo(nullDataView)
            make.size.equalTo(CGSize(width: 300, height: 44))
        }
    }
    
    func removeLoadingView() {
        MBProgressHUD.stopLoadding()
        loaddingView.removeFromSuperview()
    }
    
    func removeNullDataView() {
        MBProgressHUD.stopLoadding()
        nullDataView.removeFromSuperview()
        nullDataTip.removeFromSuperview()
    }
    
    
}


// MARK: - 通过基础型方法扩展
extension XFBaseViewController {

    func loaddingWithMsg(_ msg: String? = "玩儿命加载中...") {
        MBProgressHUD.loaddingWithMessage(msg)
    }
    
    func stopLoadding() {
        MBProgressHUD.stopLoadding()
    }
    
    func showMessage(_ msg: String, completion: (()->Void)? = nil) {
        MBProgressHUD.showMessage(msg, completion: completion)
    }
    
    func showSuccess(_ msg: String = "操作成功") {
        MBProgressHUD.showSuccess(msg)
    }
    
    func showError(_ msg: String = "操作失败") {
        MBProgressHUD.showError(msg)
    }
    
    func showProgress(_ progress: Float, msg: String? = "精彩即将亮相...", mode: MBProgressHUDMode = .annularDeterminate) {
        MBProgressHUD.showProgress(progress, message: msg, mode: mode)
    }
}
