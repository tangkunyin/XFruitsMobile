//
//  XFruitsAddressTextViewWithPlaceHolderTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/19/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddressTextViewWithPlaceHolderTableViewCell: UITableViewCell ,UITextViewDelegate{

    
    var descAddress:UITextView?
    var placeHolderLabel:UILabel?
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    
    
    
    func tableView() -> UITableView {
        var tableView: UIView = self.superview!
        while !tableView.isKind(of: UITableView.self) {
            tableView = tableView.superview!
        }
        return (tableView as? UITableView)!
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil || textView.text.isEmpty {
            self.placeHolderLabel?.text = "详细地址（具体到门牌号）"
        }
        else{
            self.placeHolderLabel?.text = ""
        }
     
    }
    
    func  setUpUI() {
        // 详细地址
        descAddress = UITextView()
        self.addSubview(descAddress!)
        descAddress?.delegate = self
        descAddress?.font = UIFont.systemFont(ofSize: 14)
//        descAddress?.isScrollEnabled = false
        descAddress?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-5)

        })
        placeHolderLabel = UILabel()
        placeHolderLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        placeHolderLabel?.text = "详细地址（具体到门牌号）"
        placeHolderLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(placeHolderLabel!)

        
        placeHolderLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(10)

            make.height.equalTo(14)
          
        })
//        placeHolderLabel?.text = ""
    
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
