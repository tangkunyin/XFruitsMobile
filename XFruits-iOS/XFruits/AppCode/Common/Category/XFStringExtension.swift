//
//  XFStringExtension.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/11.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation

extension String {
    
    public func isEmptyString(_ str: String?) -> Bool {
        if let str = str {
            return str.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        }
        return false
    }
    
    
}
