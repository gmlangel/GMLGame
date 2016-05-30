//  引擎的图像渲染器
//  GMLRenderManager.swift
//  GMLGame
//
//  Created by guominglong on 16/1/20.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLRenderManager:NSObject{
    
    /**
     渲染帧频
     */
    private var _frameRate:Int! = 30;
    public var frameRate:Int!{
        get{
            return _frameRate;
        }
        set{
            _frameRate = newValue;
            timeStep = 1.0/Double(_frameRate);
            if(nt != nil)
            {
                stop();//停止渲染
                start();//重新开始渲染
            }
        }
    }
    
    private var timeStep:NSTimeInterval! = 1.0/30;
    private var nt:NSTimer?;
    
    private var aniLayers:[CALayer]!;
    public override init()
    {
        super.init();
        aniLayers = [];
    }
    private static var _instance:GMLRenderManager?;
    public static var instance:GMLRenderManager!{
        get{
            if(_instance == nil)
            {
                _instance = GMLRenderManager();
            }
            return _instance;
        }
    }
    
    /**
     开始渲染
     */
    public func start()
    {
        nt = NSTimer.scheduledTimerWithTimeInterval(timeStep, target: self, selector: Selector("toRender"), userInfo: nil, repeats: true);
    }
    
    /**
     停止渲染
     */
    public func stop()
    {
        if(nt != nil)
        {
            nt?.invalidate();
        }
    }
    
    /**
     添加被渲染图层
     */
    public func addRenderLayer(layer:CALayer)
    {
        aniLayers.append(layer);
    }
    
    /**
     渲染图层一次
     */
    public func toRender()
    {
        for lay in aniLayers
        {
            lay.setNeedsDisplay();
        }
    }
}