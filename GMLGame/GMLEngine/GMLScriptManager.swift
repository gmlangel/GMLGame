//  脚本管理器
//  ScriptManager.swift
//  GMLGame
//
//  Created by guominglong on 16/1/18.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLScriptManager{

    private static var _instance:GMLScriptManager? = nil;
    
    public static var instance:GMLScriptManager{
        get{
            if(_instance == nil)
            {
                _instance = GMLScriptManager();
            }
            return _instance!;
        }
    }
    
    /**
     动作脚本
     */
    public var actionScriptDic:[String:NSArray]?;
    
    
    
    public init()
    {
        
    }
    
    /**
     通过nameKey和aniType，匹配指定播放贞的图像绘制区域
     */
//    public func getAniBitmapRect(nameKey:String,gmlAniType:String,currentFrameIdx:Int)->(CGRect?,Int)
//    {
//        let arr:NSArray? = actionScriptDic![nameKey + gmlAniType];
//        if(arr != nil && arr?.count > 0)
//        {
//            if(currentFrameIdx >= arr?.count)
//            {
//                return (nil,0);
//            }else{
//                return (arr![currentFrameIdx] as? CGRect,currentFrameIdx);
//            }
//        }else{
//            return (nil,0);
//        }
//    }
}