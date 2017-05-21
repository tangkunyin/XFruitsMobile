
//
//  XFCommonUtils.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit


/// 当前时间的时间戳
public func currentTimestamp() ->Int {
    let now = Date()
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}
