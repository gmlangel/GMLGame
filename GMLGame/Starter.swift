//
//  Starter.swift
//  GMLGame
//
//  Created by guominglong on 16/1/19.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class Starter:GMLObject{
    public override init() {
        super.init();
    }
    
    public func start()
    {
        //加载主配置文件
        
        //加载资源包
        
        //加载场景
        
        
        //测试用
        let config:NSDictionary = NSDictionary(contentsOfFile: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/aniTest.plist")!;
        GMLFactoryManager.instance.addMonsterConfig(config);
        //开启所有的动画渲染器
        startRenderManager();
    }
    
    /**
     添加需要被渲染的动画图层
     */
    public func addRenderLayer(layer:CALayer)
    {
        GMLRenderManager.instance.addRenderLayer(layer);
    }
    
    /**
     开启渲染器
     */
    public func startRenderManager()
    {
        GMLRenderManager.instance.frameRate = 30;
        GMLRenderManager.instance.start();
    }
    
    /**
     停止渲染器
     */
    public func stopRenderManager()
    {
        GMLRenderManager.instance.stop();
    }
}