//
//  XFAddToCartAnimationTool.swift
//  XFruits
//
//  Created by zhaojian on 11/15/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
typealias animationFinishedBlock = (_ finish : Bool) -> Void

class XFAddToCartAnimationTool: NSObject,CAAnimationDelegate {
    
    static let shared = XFAddToCartAnimationTool()

    private var layer : CALayer?
   
    var aniFinishedBlock : animationFinishedBlock?
    
    override init() {
        super.init()
    }
    
    //MARK: - 开始走的方法
    func startAnimation(view : UIView, startPoint:CGPoint, endPoint : CGPoint, andFinishBlock completion : @escaping animationFinishedBlock) -> Void{
        layer = CALayer()
        layer?.contents = view.layer.contents
        layer?.frame = CGRect(x:startPoint.x,y:startPoint.y,width:40,height:40)
//        layer?.contentsGravity = kCAGravityResize
        layer?.position = CGPoint(x:startPoint.x,y:startPoint.y)
        
        let myWindow : UIView = ((UIApplication.shared.delegate?.window)!)!
        myWindow.layer.addSublayer(layer!)
 
        //创建路径 其路径是抛物线
        let path =  CGMutablePath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, control: CGPoint(x:endPoint.x,y:startPoint.y))

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.rotationMode = kCAAnimationRotateAuto
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.duration = 0.5
        expandAnimation.fromValue = 1
        expandAnimation.toValue = 1.5
        expandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let narrowAnimation = CABasicAnimation(keyPath: "transform.scale")
        narrowAnimation.beginTime = 0.5
        narrowAnimation.fromValue = 1.5
        narrowAnimation.duration = 0.6
        narrowAnimation.toValue = 0.5
        narrowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let groups:CAAnimationGroup = CAAnimationGroup()
        groups.duration = 1.1
        groups.delegate = self
        groups.animations = [animation, expandAnimation, narrowAnimation]
        groups.isRemovedOnCompletion = false
        
        layer?.add(groups, forKey: "groups")
        aniFinishedBlock = completion
    }
    
    //MARK: - 上下浮动
    func shakeAnimation(shakeView : UIView){
        let shakeAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        shakeAnimation.duration = 0.25
        shakeAnimation.fromValue = NSNumber.init(value: -5)
        shakeAnimation.toValue = NSNumber.init(value: 5)
        shakeAnimation.autoreverses = true
        shakeView.layer.add(shakeAnimation, forKey: nil)
       
    }
    //MARK: -CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == layer!.animation(forKey: "groups"){
            layer?.removeFromSuperlayer()
            layer = nil
            if (aniFinishedBlock != nil) {
                aniFinishedBlock!(true)
            }
        }
    }
    
}
