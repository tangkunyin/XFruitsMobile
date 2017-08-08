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

class XFWebViewController: XFBaseSubViewController,WKUIDelegate ,WKNavigationDelegate   {
    
    var urlString:String = ""
    
    
    lazy var webview:WKWebView = {
        let webview = WKWebView.init()
        let url:NSURL   = NSURL.init(string: "http://www.jianshu.com")!
        let request = NSURLRequest.init(url: url as URL)
        webview.uiDelegate = self
        MBProgressHUD.showMessage("正在加载……") {
            
        }
        webview.load(request as URLRequest)
        
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.addSubview(webview)
        webview.snp.makeConstraints({ (make) in
            make.center.size.equalTo(self.view)
        })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       MBProgressHUD.showSuccess("")
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
         MBProgressHUD.showError("网络不给力啊~")
    }

}
