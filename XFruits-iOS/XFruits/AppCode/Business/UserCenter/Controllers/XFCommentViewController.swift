//
//  XFCommentViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/26.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let defaultTags = ["灰常赞","还行吧","很精致","好便宜","物流慢","无言表"]
fileprivate let defaultComments = ["很惊喜，没想到还有这种精致的生活方式...",
                                   "苹果很好吃啦，不错~",
                                   "就是喜欢你们这种价值观",
                                   "好便宜啊，比我在超市和果摊的好多了，墙裂推荐",
                                   "东西确实不错，但物流真的是醉了...",
                                   "无法用言语表达的爱，下次还来"]

class XFCommentViewController: XFBaseSubViewController {

    var order: XFOrderContent?
    
    var orderId: String = ""
    
    lazy var commentSizer: UISegmentedControl = {
        let segmente = UISegmentedControl(items: defaultTags)
        let normalAttributes = [NSAttributedStringKey.foregroundColor:XFConstants.Color.salmon,
                                NSAttributedStringKey.font:pfnFontWithSize(12)]
        let selectAttributes = [NSAttributedStringKey.foregroundColor:XFConstants.Color.white,
                                NSAttributedStringKey.font:pfnFontWithSize(12)]
        segmente.setTitleTextAttributes(normalAttributes, for: .normal)
        segmente.setTitleTextAttributes(selectAttributes, for: .selected)
        segmente.selectedSegmentIndex = 0
        segmente.apportionsSegmentWidthsByContent = true
        segmente.backgroundColor = XFConstants.Color.white
        segmente.tintColor = XFConstants.Color.salmon
        return segmente
    }()
    
    lazy var commentText: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = defaultComments[Int(arc4random_uniform(6))]
        textView.returnKeyType = .done
        return textView
    }()
    
    lazy var saveBtn :UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.backgroundColor = UIColor.white
        saveBtn.setTitle("保 存", for: .normal)
        saveBtn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        saveBtn.titleLabel?.font = XFConstants.Font.pfn16
        saveBtn.layer.cornerRadius = 6
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = XFConstants.Color.salmon.cgColor
        saveBtn.layer.masksToBounds = true
        saveBtn.addTarget(self, action: #selector(saveComment), for: .touchUpInside)
        return saveBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let order = order {
            title = "说出你的心里话"
            orderId = order.orderId
            makeCommentAddConstrains()
        }
    
        
    }
    
    private func makeCommentAddConstrains() {
        view.addSubview(commentSizer)
        view.addSubview(commentText)
        view.addSubview(saveBtn)
        commentSizer.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(35)
        }
        commentText.snp.makeConstraints { (make) in
            make.top.equalTo(commentSizer.snp.bottom).offset(15)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(120)
        }
        saveBtn.snp.makeConstraints { (make) in
            make.top.equalTo(commentText.snp.bottom).offset(30)
            make.height.equalTo(44)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }

    @objc private func saveComment() {
        guard !commentText.text.isEmpty else {
            showError("心里话总要说一句吧")
            return
        }
        
    }
}

extension XFCommentViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
