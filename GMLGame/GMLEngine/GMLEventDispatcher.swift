//  所有GML引擎的事件派发者的基类
//  GMLEventDispatcher.swift
//  GMLGame
//
//  Created by guominglong on 16/1/15.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLEventDispatcher:NSObject{

    private var eventDic:[GMLEventType:(GMLEvent)->()]?;
    /**
     添加事件
     */
    public func addEventListener(eventName:GMLEventType,execFunc:(GMLEvent)->()){
        if(eventDic == nil)
        {
            func rootFun(e:GMLEvent){}
            eventDic = [GMLEventType.NONE:rootFun];
        }
        eventDic![eventName] = execFunc;
    }
    
    /**
     移除指定事件
     */
    public func removeEventListener(eventName:GMLEventType){
        if(eventDic == nil)
        {
            return;
        }
        if(hasEventListener(eventName) == true)
        {
            eventDic?.removeValueForKey(eventName);
        }
        if(eventDic?.count == 1)
        {
            //当前Dic只剩下一个rootkey的时候，清空当前DIC
            eventDic?.removeAll();
            eventDic = nil;
        }
    }
    
    
    /**
     移除所有事件
     */
    public func removeAllEventListener(){
        if(eventDic == nil)
        {
            return;
        }
        eventDic?.removeAll();
        eventDic = nil;
    }
    
    /**
     判断是否有指定事件监听
     */
    public func hasEventListener(eventName:GMLEventType!)->Bool{
        if(eventDic == nil)
        {
            return false;
        }else{
            return eventDic!.keys.contains(eventName);
        }
        
    }
    
    /**
     触发监听
     */
    public func dispatchEvent(e:GMLEvent){
        for key in (eventDic?.keys)!
        {
            if(key == e.eventType)
            {
                eventDic![key]!(e);
                break;
            }
        }
    }

}