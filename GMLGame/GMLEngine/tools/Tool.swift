//
//  tool.swift
//  GMLGame
//
//  Created by guominglong on 16/1/17.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class Tool{
    public init()
    {
        
    }
    public static func getNetFileURL(path:String)->NSURL
    {
        return NSURL(string: path)!;
    }
    
    public static func getNetWebserviceURL(path:String)->NSURL
    {
        return NSURL(string: path)!;
    }
    
    public static func getLocalFileURL(path:String,isDirectory:Bool = false)->NSURL{
        return NSURL(fileURLWithPath: path, isDirectory: isDirectory)
    }
}