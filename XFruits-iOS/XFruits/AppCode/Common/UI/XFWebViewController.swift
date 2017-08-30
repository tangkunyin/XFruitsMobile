//
//  XFWebViewController.swift
//  XFruits
//
//  Created by zhaojian on 8/8/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

fileprivate let webViewLoadProgressKey = "estimatedProgress"

class XFWebViewController: XFBaseSubViewController {
    
    var urlString: String?
    
    lazy var webview: WKWebView = {
        let web = WKWebView()
        web.uiDelegate = self
        web.navigationDelegate = self
        return web
    }()
    
    deinit {
        webview.removeObserver(self, forKeyPath: webViewLoadProgressKey)
        webview.uiDelegate = nil
        webview.navigationDelegate = nil
    }
    
    convenience init(withUrl url: String) {
        self.init()
        urlString = url
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urlString = urlString, let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 30
            webview.load(request)
        } else {
            handleError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        webview.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
        //添加进度监听
        webview.addObserver(self, forKeyPath: webViewLoadProgressKey, options: .new, context: nil)
    }
    
    fileprivate func handleError(){
        weak var weakSelf = self
        MBProgressHUD.showMessage("页面加载错误，请稍后再试~", completion: {
            weakSelf?.backToParentController()
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == webViewLoadProgressKey, let change = change {
            let progress = change[NSKeyValueChangeKey.newKey] as? Float
//            MBProgressHUD.showProgress(progress ?? 0, message: "努力加载中...")
            dPrint(progress ?? 0)
        }
    }
}

extension XFWebViewController: WKUIDelegate,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loaddingWithMsg("努力加载中...")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoadding()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.stopLoading()
        stopLoadding()
        handleError()
    }
}
