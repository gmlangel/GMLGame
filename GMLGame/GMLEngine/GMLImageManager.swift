//  游戏引擎的图像管理器
//  GMLImageManager.swift
//  GMLGame
//
//  Created by guominglong on 16/1/19.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import AppKit
public class GMLImageManager{
    private var _imgDic:[String:NSBitmapImageRep?]?;
    
    private static var _instance:GMLImageManager?;
    
    
    public static var instance:GMLImageManager!{
        get{
            if(_instance == nil)
            {
                _instance = GMLImageManager();
            }
            return _instance;
        }
    }
    public init()
    {
        _imgDic = ["root":nil];
    }
    
    
    public func addImgForKey(strKey:String,nb:NSBitmapImageRep?)
    {
        //相同key的资源不重复加载
        if(hasImgForKey(strKey))
        {
            return;
        }
        _imgDic![strKey] = nb;
    }
    
    /**
     加载指定路径的图片到图片管理器
     */
    public func loadImgForKeyByLocalPath(strKey:String,bitmapPath:String)
    {
        //相同key的资源不重复加载
        if(hasImgForKey(strKey))
        {
            return;
        }
        GMLDataResourceManager.instance.addResourceByLocalPath(strKey, path: bitmapPath);
        let nd:NSData? = GMLDataResourceManager.instance.getNSDataByName(strKey);
        if(nd == nil)
        {
            _imgDic![strKey] = nil;
        }else{
            _imgDic![strKey] = NSBitmapImageRep(data: nd!);
        }
        
    }
    
    
    public func hasImgForKey(strKey:String) -> Bool
    {
       return _imgDic![strKey] != nil
    }
    
    public func getImgForKey(strKey:String)->NSBitmapImageRep?
    {
        if(hasImgForKey(strKey) == true)
        {
            return _imgDic![strKey]!;
        }else{
            return nil;
        }
        
    }
}