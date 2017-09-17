//
//  XFExpandImage.swift
//  XFruits
//
//  Created by 赵健 on 17/09/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import UIKit

class XFExpandImage:NSObject{
    
   
// var editStyle: Int?
   static var oldFrame:CGRect?
    
    
    func scanBigImageWithImageView(currentImageView:UIImageView,alpha:CGFloat)  {
        let image = currentImageView.image
        
        let window = UIApplication.shared.keyWindow
        let backgroundView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        XFExpandImage.oldFrame = currentImageView.convert(currentImageView.bounds, to: window)
        
        
        backgroundView.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: alpha)
        
        backgroundView.alpha = 0
        let imageView = UIImageView.init(frame: XFExpandImage.oldFrame!)
        imageView.image  = image
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 1024
        backgroundView.addSubview(imageView)
        
        window?.addSubview(backgroundView)
        
        window?.isUserInteractionEnabled = true
        backgroundView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
    
        backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.hideBackgroundView(_:))))
        
        UIView.animate(withDuration: 0.4, animations: { 
            let y,width,height:CGFloat
            y = (UIScreen.main.bounds.size.height - (image?.size.height)! * UIScreen.main.bounds.size.width / (image?.size.width)! ) * 0.5
            width = UIScreen.main.bounds.size.width
            height = (image?.size.height)! * UIScreen.main.bounds.size.width / (image?.size.width)!
            imageView.frame  = CGRect.init(x: 0, y: y, width: width, height: height)
            backgroundView.alpha = 1
            
        }) { (finished) in
            
        }
    }
    
    
    
    @objc fileprivate func hideBackgroundView(_ tap:UITapGestureRecognizer) {
        let backgroundView = tap.view
        let imageViw = tap.view?.viewWithTag(1024)
        UIView.animate(withDuration: 0.4, animations: {
            imageViw?.frame = XFExpandImage.oldFrame!
            backgroundView?.alpha = 0
        }) { (finished) in
            backgroundView?.removeFromSuperview()
        }
    }
}
