//  所有对象的基类
//  GMLObject.swift
//  GMLGame
//
//  Created by guominglong on 16/1/18.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLObject{
    private var _dispatchObj:GMLEventDispatcher;

    public init()
    {
        _dispatchObj = GMLEventDispatcher();
    }
    
    /**
     添加事件
     */
    public func addEventListener(eventName:GMLEventType,execFunc:(GMLEvent)->()){
        _dispatchObj.addEventListener(eventName, execFunc: execFunc);
    }
    
    /**
     移除指定事件
     */
    public func removeEventListener(eventName:GMLEventType){
        _dispatchObj.removeEventListener(eventName);
    }
    
    
    /**
     移除所有事件
     */
    public func removeAllEventListener(){
        _dispatchObj.removeAllEventListener();
    }
    
    /**
     判断是否有指定事件监听
     */
    public func hasEventListener(eventName:GMLEventType!)->Bool{
        return _dispatchObj.hasEventListener(eventName);
    }
    
    /**
     触发监听
     */
    public func dispatchEvent(e:GMLEvent){
        return _dispatchObj.dispatchEvent(e);
    }

}