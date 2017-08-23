//
//  XFPayTimerCountDownViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/13.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFPayTimerCountDownViewCell: UITableViewCell {

    weak var countDownTimer: Timer?
    
    var onTimerEnd: (()->Void)?
    
    var diffTime: Int = 0 {
        didSet {
            refreshTimerCountdown(diffTime)
        }
    }
    
    var endTime: Int {
        get {
            return diffTime
        }
        set {
            diffTime = newValue / 1000 - XFDataGlobal.shared.serverTime / 1000
        }
    }
    
    func invalidateTimer(){
        if let timer:Timer = countDownTimer {
            if timer.isValid {
                timer.invalidate()
                countDownTimer = nil
            }
        }
    }
    
    // 一位数补零
    func ten(_ t: Double) -> String {
        var time = String(format:"%.0f",t)
        if (t < 10.0) {
            time = String(format:"0%.0f",t)
        }
        return time
    }
    
    func refreshTimerCountdown(_ time: Int){
        if (time >= 0){
            let day = floor(Double(time / (60 * 60 * 24)))
            let hour = floor(Double(time / (60 * 60))) - day * 24
            let minute = floor(Double(time / 60)) - (day * 24 * 60) - (hour * 60)
            let second = floor(Double(time)) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60)
            remainTimeLabel.text = "\(ten(minute)) : \(ten(second))"
        } else {
            invalidateTimer()
            waitPayTip.text = "订单已失效，无法为您继续支付..."
            waitPayTip.textColor = XFConstants.Color.reddishPink
            if let onEnd = onTimerEnd {
                onEnd()
            }
        }
    }
    
    @objc func updateTime(){
        diffTime -= 1
    }
    
    private func customInit(){
        setUpUI()
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateTime),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit();
    }
    
    private lazy var waitPayTip:UILabel = {
        let waitPayTip = UILabel()
        waitPayTip.text = "已下单，您需要继续完成支付！"
        waitPayTip.textColor = colorWithRGB(102, g: 102, b: 102)
        waitPayTip.font  = UIFont.systemFont(ofSize: 14)
        waitPayTip.textAlignment = NSTextAlignment.center
        return waitPayTip
    }()
    
    private lazy var remainTimeLabel:UILabel = {
        let remainTimeLabel = UILabel()
        remainTimeLabel.text = "00 : 00"
        remainTimeLabel.textColor = colorWithRGB(102, g: 102, b: 102)
        remainTimeLabel.font  = UIFont.systemFont(ofSize: 48)
        remainTimeLabel.textAlignment = NSTextAlignment.center
        return remainTimeLabel
    }()
    
    private func setUpUI() {
        addSubview(waitPayTip)
        addSubview(remainTimeLabel)
        waitPayTip.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(32)
            make.height.equalTo(14)
            make.centerX.equalTo(self)
        })
        remainTimeLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(waitPayTip.snp.bottom).offset(32)
            make.height.equalTo(48)
            make.centerX.equalTo(self)
        })
    }


}
