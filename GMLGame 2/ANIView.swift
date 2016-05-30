//
//  ANIView.swift
//  GMLGame
//
//  Created by guominglong on 16/1/14.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import AppKit
public class ANIView:NSView{
    
    private var scale_enum:String = "transform.scale.x";
    private var ani:CABasicAnimation!;
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        
        ginit();
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    func ginit()
    {
        self.wantsLayer = true;
        //声明一个进行动画的对象
        let tlayer:CALayer = CALayer();
        tlayer.backgroundColor = NSColor.blueColor().CGColor;
        tlayer.frame = NSRect(x: 0, y: 0, width: 100, height: 100);
        self.layer?.addSublayer(tlayer);
        
        ani = CABasicAnimation(keyPath: scale_enum);//keyPath标识要改变的属性
        ani.delegate = self;//这样可以监听到 动画的开始与结束
        ani.duration = 0.3;//一次动画的缓动时间
        
        ani.fromValue = NSNumber(float: 1);//设置开始值
        ani.toValue = NSNumber(float: 0.5);//设置想要的结果值
        ani.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);//设置缓动函数
        ani.fillMode = kCAFillModeForwards;
        ani.repeatCount = 1;//设置缓动的重复次数
        ani.removedOnCompletion = true;//动画结束时，销毁动画
        self.layer?.addAnimation(ani, forKey: nil);
    }
    
    
    public override func animationDidStart(anim: CAAnimation) {
        NSLog("ANIstart");
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        NSLog("ANIstop");
    }
    
}