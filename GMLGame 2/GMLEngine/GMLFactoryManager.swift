//  对象工厂，负责生产对象
//  GMLConfigManager.swift
//  GMLGame
//
//  Created by guominglong on 16/1/19.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLFactoryManager:GMLObject{
    
    /**
     配置文件集合
     */
    private var configDic:[String:NSDictionary]!;
    
    /**
     区域范围集合
     */
    private var rectDic:[String:[CGRect]]!;
    private static var _instance:GMLFactoryManager?;
    public static var instance:GMLFactoryManager!{
        get{
            if(_instance == nil)
            {
                _instance = GMLFactoryManager()
            }
            return _instance!;
        }
    }
    
    public override init() {
        super.init();
        configDic = ["root":NSDictionary()];
        rectDic = ["root":[]];
    }
    
    /**
     添加动画配置文件
     */
    public func addMonsterConfig(dic:NSDictionary)
    {
        let nameKey:String = dic.valueForKey("nameKey") as! String;
        //已经添加过的文件，不重复解析
        if(configDic.keys.contains(nameKey))
        {
            return;
        }
        //解析，加载资源，并存储配置文件
        configDic[nameKey] = dic;
        let arr:NSArray = dic.valueForKey("actions") as! NSArray;
        for aniType in arr
        {
            let actionDic:NSDictionary? = dic.valueForKey(aniType as! String) as? NSDictionary;
            //当未找到指定的动作集合时，跳过加载资源，执行下一个动作资源的解析与加载
            if(actionDic == nil)
            {
                continue;
            }
            //加载图像资源并存储到GMLImageManager管理器中，以供以后使用
            GMLImageManager.instance.loadImgForKeyByLocalPath("\(nameKey)\(aniType)", bitmapPath: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/\(actionDic!.valueForKey("imgSource") as! String)");
            //将动画坐标字符串转换为CGRect,存放在rectDic中，用于之后遍历
            let frames:NSMutableArray = actionDic!.valueForKey("frames") as! NSMutableArray;
            var rects:[CGRect] = [];
            let j:Int = frames.count;
            for(var i:Int=0;i<j;i++)
            {
                rects.append(getFrame(frames[i] as! String));
            }
            rectDic["\(nameKey)\(aniType)"] = rects;
        }
    }
    
    private func getFrame(str:String)->CGRect{
        let arr:[NSString] = str.componentsSeparatedByString(",");
        return CGRect(x: CGFloat((arr[0]).floatValue), y: CGFloat((arr[1]).floatValue), width: CGFloat((arr[2]).floatValue), height: CGFloat((arr[3]).floatValue));
    }
    
    /**
     通过nameKey和aniType，匹配指定播放贞的图像绘制区域
     */
    public func getAniBitmapRect(nameKey:String,gmlAniType:String,var currentFrameIdx:Int,isLoop:Bool = true)->(CGRect?,Int,Bool)
    {
        let arr:[CGRect]? = rectDic["\(nameKey)\(gmlAniType)"];
        if(arr != nil && arr?.count > 0)
        {
            if(currentFrameIdx >= arr?.count)
            {
                if(isLoop)
                {
                    return (nil,-1,true);//通知动画播放完毕,monster内部会处理循环播放
                }else{
                    currentFrameIdx = arr!.count - 1;
                    return (arr![currentFrameIdx],currentFrameIdx,false);
                }
            }else{
                return (arr![currentFrameIdx],currentFrameIdx,false);
            }
        }else{
            return (nil,-1,true);
        }
    }
    
    /**
     通过nameKey构建一个动画物体
     */
    public func getMonster(nameKey:String)->GMLMonster?
    {
        if(!configDic.keys.contains(nameKey))
        {
            return nil
        }
        let monster:GMLMonster = GMLMonster();
        monster.fillInfo(nameKey, align: configDic[nameKey]?.valueForKey("align") as! String, defaultAniType: (configDic[nameKey]?.valueForKey("actions") as! NSArray)[0] as! String);
        return monster;
    }
}