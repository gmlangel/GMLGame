//  资源管理器
//  ResourceManager.swift
//  GMLGame
//
//  Created by guominglong on 16/1/17.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLDataResourceManager{
    
    /**
     一般资源文件
     */
    public static let NOMAR_FILE:String = "ResourceManager.file";
    
    /**
     被压缩过的资源文件
     */
    public static let ZIP_FILE:String = "ResourceManager.ZipFile";
    
    private static var _instance:GMLDataResourceManager?;
    
    public static var instance:GMLDataResourceManager!{
        get{
            if(_instance == nil)
            {
                _instance = GMLDataResourceManager()
            }
            return _instance;
        }
    }
    
    /**
     存放资源的集合
     */
    private var resourceDic:[String:NSData]!;
    
    /**
    临时存放fileReader的集合
    */
    private var fileReaderDic:[String:FileReader]!;
    
    /**
     临时存放fileReader加载完毕后的NSData的类型
     */
    private var fileType:[String:String]!;
    public init()
    {
        resourceDic = ["root":NSData()];
        fileReaderDic = ["root":FileReader()];
        fileType = ["root":GMLDataResourceManager.NOMAR_FILE];
    }
    
    public func getNSDataByName(key:String)->NSData?
    {
        if(resourceDic!.keys.contains(key) == false)
        {
            return nil
        }else{
            return resourceDic[key];
        }
    }
    
    /**
     添加网络资源
     type = NOMAR_FILE , ZIP_FILE
     */
    public func addResourceByNetURL(key:String,url:NSURL)
    {
        let file:FileReader = FileReader();
        file.addEventListener(GMLEventType.COMPLETE, execFunc: fileLoadend);
        file.addEventListener(GMLEventType.IO_ERROR, execFunc: onfileLoadError);
        file.asyncLoadFileByURL(url, flagName: key);
        fileReaderDic[key] = file;
        
        var type:String;
        if((url.path?.lowercaseString.containsString(".zip"))! == true)
        {
            type = GMLDataResourceManager.ZIP_FILE;
            fileType[key] = type;
        }
    }
    /**
     加载完毕
     */
    private func fileLoadend(e:GMLEvent)
    {
       
        let fr:FileReader = e.target as! FileReader;
        //判断是否需要对NSData做二次处理
        if(fileType[fr.flagName] == GMLDataResourceManager.ZIP_FILE)
        {
            NSLog("正在解压资源\(fr.flagName)");
            //zip解压操作,解压后需要移除fileType集合中的key
            let a = 1;
        }else if(fileType[fr.flagName] == nil){
            NSLog("资源\(fr.flagName)加载完毕");
            //向资源集合中添加资源
            resourceDic[fr.flagName] = fr.resultData!;
            //释放FileReader
            disposeFileReader(fr);
        }
        
        
    }
    
    /**
     加载进度
     */
    private func onfileLoadError(e:GMLEvent)
    {
        let fr:FileReader = e.target as! FileReader
        NSLog("资源%@加载失败，原因：%@", fr.flagName,e.msg);
        disposeFileReader(fr);
        fileType.removeValueForKey(fr.flagName);
    }
    
    private func disposeFileReader(fr:FileReader)
    {
        //移除监听
        fr.removeEventListener(GMLEventType.COMPLETE);
        fr.removeEventListener(GMLEventType.IO_ERROR);
        //从fileReaderDic移除fileReader
        fileReaderDic.removeValueForKey(fr.flagName);
    }
    
    /**
     加载本地资源
     type = NOMAR_FILE , ZIP_FILE
     */
    public func addResourceByLocalPath(key:String,path:String)
    {
        var isDic:ObjCBool = ObjCBool(false);
        let exitis:Bool = NSFileManager.defaultManager().fileExistsAtPath(path,isDirectory: &isDic);
        if(exitis == false)
        {
            NSLog("资源%@加载失败，原因：%@", key,"\(path)不存在");
            return;
        }
        if(isDic)
        {
            NSLog("资源%@加载失败，原因：%@", key,"\(path)是一个目录");
//            let paths:[String] = NSFileManager.defaultManager().subpathsAtPath(path)!;
//            //需要遍历目录，循环加载
//            for p in paths
//            {
//                NSLog(p);
//            }
        }else{
            //直接加载文件
            var type:String;
            if(path.lowercaseString.containsString(".zip") == true)
            {
                type = GMLDataResourceManager.ZIP_FILE;
                fileType[key] = type;
                //执行zip解压
            }else{
                let nd:NSData = NSData(contentsOfFile: path)!;
                resourceDic[key] = nd;
                NSLog("资源\(key)加载完毕");
            }
        }

    }
    
    
}