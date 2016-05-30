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
     物体动作的序列帧图像的集合
     */
    private var imgDic:[String:NSBitmapImageRep?];
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
        configDic = ["root":NSDictionary()];
        imgDic = ["root":nil];
        super.init();
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
            //加载图像资源
            let key:String = "\(nameKey)\(aniType)";
            GMLDataResourceManager.instance.addResourceByLocalPath(key, path: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/\(actionDic!.valueForKey("imgSource") as! String)");
            //将动画坐标字符串转换为CGRect,存放在rectDic中，用于之后遍历
            let frames:NSMutableArray = actionDic!.valueForKey("frames") as! NSMutableArray;
            let j:Int = frames.count;
            let bmp:NSBitmapImageRep = NSBitmapImageRep(data: GMLDataResourceManager.instance.getNSDataByName(key)!)!;
            let CGbmp:CGImageRef = bmp.CGImage!;
            let CGBmpHeight:CGFloat = bmp.size.height;
            var key2:String = "";
            for(var i:Int=0;i<j;i++)
            {
                key2 = key + "\(i)";
                //NSBitmapRep采用笛卡尔坐标系，而CGImageCreateWithImageInRect中的rect指代的坐标系正好垂直颠倒，所以需要做坐标系转换后再进行截图。
                let grect:CGRect = getFrame(frames[i] as! String,cgHeigth: CGBmpHeight);
                //将动作的序列帧图存放在imgDic中，以供以后使用
                imgDic[key2] = NSBitmapImageRep(CGImage: CGImageCreateWithImageInRect(CGbmp, grect)!);
            }
        }
    }
    
    private func getFrame(str:String,cgHeigth:CGFloat)->CGRect{
        //NSBitmapRep采用笛卡尔坐标系，而CGImageCreateWithImageInRect中的rect指代的坐标系正好垂直颠倒，所以需要做坐标系转换后再进行截图。
        let arr:[NSString] = str.componentsSeparatedByString(",");
        return CGRect(x: CGFloat((arr[0]).floatValue), y: cgHeigth - CGFloat((arr[1]).floatValue) - CGFloat((arr[3]).floatValue), width: CGFloat((arr[2]).floatValue), height: CGFloat((arr[3]).floatValue));
    }
    
    /**
     通过nameKey和aniType，匹配指定播放贞的图像绘制区域
     */
    public func getAniBitmap(nameKey:String,gmlAniType:String,currentFrameIdx:Int,isLoop:Bool = true)->NSBitmapImageRep?
    {
        let key:String = "\(nameKey)\(gmlAniType)\(currentFrameIdx)";//"FirstMonsterANI_ATTACK0";//
        if(imgDic[key] == nil)
        {return nil}
        else
        {return imgDic[key]!}

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