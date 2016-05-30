//
//  FileReader.swift
//  GMLGame
//
//  Created by guominglong on 16/1/15.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class FileReader:GMLEventDispatcher,NSURLConnectionDataDelegate{
    
    public var resultData:NSMutableData?;
    private var totalSize:CGFloat!;
    private var loadedSize:CGFloat!;
    public var timeOut:NSTimeInterval! = 1000;//1000秒超时
    
    /**
    此fileReader对象的字符串标识
    */
    public var flagName:String! = "";
    /**
     根据url异步加载文件
     */
    public func asyncLoadFileByURL(url:NSURL,flagName:String="")
    {
        if(NSURLConnection.canHandleRequest(NSURLRequest(URL: url)) == true)
        {
            totalSize = 0;
            loadedSize = 0;
            self.flagName = flagName;
            let res:NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: timeOut);//1000秒超时
            let con:NSURLConnection = NSURLConnection(request: res, delegate: self, startImmediately: true)!;
        }else{
            dispatchEvent(GMLEvent(eventType: GMLEventType.IO_ERROR,target: self, _msg: "url不可用"));
        }
    }
    
    
    public func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        resultData?.appendData(data);
        loadedSize = CGFloat((resultData?.length)!);
        dispatchEvent(GMLEvent(eventType: GMLEventType.PROGRESS, loadedBytes: loadedSize, totalBytes: totalSize));
    }
    //收到服务器的响应
    public func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        resultData = NSMutableData();
        let httpResponse:NSHTTPURLResponse = response as! NSHTTPURLResponse;
        let httpResponseHeaderFields:NSDictionary = NSDictionary(dictionary: httpResponse.allHeaderFields);
        //获得文件的完整字节大小
        totalSize = CGFloat((httpResponseHeaderFields.objectForKey("Content-Length")?.longLongValue)!);
        if(totalSize == 0)
        {
            //文件不正确，取消加载
            connection.cancel();
        }
    }
    
    /**
     加载完毕
     */
    public func connectionDidFinishLoading(connection: NSURLConnection) {
        dispatchEvent(GMLEvent(eventType: GMLEventType.COMPLETE,target: self));
    }
    
    /**
     加载时发生错误
     */
    public func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        dispatchEvent(GMLEvent(eventType: GMLEventType.IO_ERROR,target: self, _msg: error.helpAnchor!));
    }
    
}