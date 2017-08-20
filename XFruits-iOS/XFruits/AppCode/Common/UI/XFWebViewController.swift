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

class XFWebViewController: XFBaseSubViewController {
    
    private var urlString: String?
    
    lazy var webview: WKWebView = {
        let webview = WKWebView()
        return webview
    }()
    
    convenience init(withUrl url: String) {
        self.init()
        urlString = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webview)
        webview.snp.makeConstraints({ (make) in
            make.center.size.equalTo(self.view)
        })
        
        if let url = urlString {
            let url:NSURL   = NSURL.init(string: url)!
            let request = NSURLRequest.init(url: url as URL)
            webview.uiDelegate = self
            webview.load(request as URLRequest)
        }
    }
    

}

extension XFWebViewController: WKUIDelegate,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        MBProgressHUD.showError("网络不给力啊~")
    }
}
