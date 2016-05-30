//  所有GML引擎事件的基类
//  GMLEvent.swift
//  GMLGame
//
//  Created by guominglong on 16/1/15.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLEvent{
    
    
    private var _eventType:GMLEventType!;
    
    /**
     事件类型
     */
    public var eventType:GMLEventType!{
        get{
            return _eventType;
        }
    }
    
    private var _msg:String! = "";
    
    /**
     事件相关描述
     */
    public var msg:String!{
        get{
            return _msg;
        }
    }
    
    
    private var _loadedBytes:CGFloat!;
    private var _totalBytes:CGFloat!;
    
    /**
     已经加载的字节数
     */
    public var loadedBytes:CGFloat!{
        get{
            return _loadedBytes;
        }
    }
    
    /**
     总字节数
     */
    public var totalBytes:CGFloat!{
        get{
            return _totalBytes;
        }
    }
    
    private var _target:AnyObject?;
    
    public var target:AnyObject?{
        get{
            return _target;
        }
    }
    
    
    public init(eventType:GMLEventType!,target:AnyObject?,_msg:String="")
    {
        self._eventType = eventType;
        self._msg = _msg;
        self._target = target;
    }
    
    public init(eventType: GMLEventType,loadedBytes:CGFloat,totalBytes:CGFloat){
        
        self._eventType = eventType;
        self._loadedBytes = loadedBytes;
        self._totalBytes = totalBytes;
    }
}

public enum GMLEventType{
    /**默认类型*/
    case NONE
    
    /**完成*/
    case COMPLETE
    
    /**IO操作，发生错误*/
    case IO_ERROR
    
    /**加载进度*/
    case PROGRESS
}