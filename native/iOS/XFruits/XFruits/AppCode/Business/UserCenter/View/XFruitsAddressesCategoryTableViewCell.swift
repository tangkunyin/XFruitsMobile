//
//  XFruitsAddressesCategoryTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/19/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddressesCategoryTableViewCell: UITableViewCell {

    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    func  setUpUI() {
        
        
        
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
