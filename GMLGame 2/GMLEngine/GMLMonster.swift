//  具有行动能力的物体
//  Monster.swift
//  GMLGame
//
//  Created by guominglong on 16/1/18.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import AppKit
public class GMLMonster:GMLObject{
    
    /**
     动画是否播放完毕
     */
    public var isPlayEnd:Bool = false;
    /**
     是否为循环动画
     */
    public var isLoopAni:Bool! = true;
    /**
     物体名称标识
     */
    public var nameKey:String!;
    
    /**
     位置
     */
    public var position:CGPoint!;
    
    /**
     图像绘制的区域信息
     */
    private var _frame:CGRect! = CGRect(x: 0, y: 0, width: 10, height: 10);
    
    private var _aniType:String! = GMLAniType.DEFAULT;
    /**
     GMLAniType
     要执行的动画类型，各种移动或者攻击，发动技能
     */
    public var aniType:String!{
        get{
            return _aniType;
        }
        set{
            _aniType = newValue;
            isPlayEnd = false;
            currentAniFrameIndex = -1;
            bitmapRect = nil;
            bitmap = GMLImageManager.instance.getImgForKey("\(nameKey)\(_aniType)");
        }
    }
    /**
     是否初始化完毕
     */
    public var isInited:Bool! = false;
    
    /**
     图像绘制时的对齐方式,默认居中显示
     */
    public var align:String = MonsterAlignType.CENTER;
    
    /**
     当前动画贞的索引
     */
    public var currentAniFrameIndex:Int = -1;
    
    /**
     当前被绘制到CGContext上的图像
     */
    private var bitmap:NSBitmapImageRep?;
    
    /**
     当前被绘制到CGContext上的图像
     */
    private var bitmapRect:CGRect?;
    
    
    public override init() {
        super.init();
       
    }
    
    
    
    /**
     通过复制创建新的副本
     */
    public func copyToNewMonster()->GMLMonster?{
        return nil;
    }
    
    
    
    public func fillInfo(nameKey:String,align:String,defaultAniType:String,_isLoopAni:Bool = true)
    {
        self.nameKey = nameKey;
        self.align  = align;
        self.aniType = defaultAniType;
        self.isInited = true;
        self.isLoopAni = _isLoopAni;
    }
    /**
     更新状态
     */
    public func update()
    {
        
        if(!isInited || isPlayEnd == true)
        {
            return;
        }

        (bitmapRect,currentAniFrameIndex,isPlayEnd) = GMLFactoryManager.instance.getAniBitmapRect(self.nameKey, gmlAniType: self.aniType, currentFrameIdx: currentAniFrameIndex + 1,isLoop: isLoopAni);
        if(isLoopAni == true && bitmapRect == nil)
        {
            //循环动画的实现
            isPlayEnd = false;
            (bitmapRect,currentAniFrameIndex,isPlayEnd) = GMLFactoryManager.instance.getAniBitmapRect(self.nameKey, gmlAniType: self.aniType, currentFrameIdx: currentAniFrameIndex + 1,isLoop: isLoopAni);
        }
    }
    
    /**
     绘制到画布
     */
    public func drawToCGContext(ctx:CGContextRef)
    {
        if(!isInited || bitmap == nil || bitmapRect == nil)
        {
            return;
        }
        _frame.size.width = (bitmapRect?.size.width)!;
        _frame.size.height = (bitmapRect?.size.height)!;
        switch(align)
        {
            case MonsterAlignType.TOP:
                _frame.origin.x = position.x - _frame.size.width/2.0;
                _frame.origin.y = position.y - _frame.size.height;
                break;
            case MonsterAlignType.TOP_LEFT:
                _frame.origin.x = position.x;
                _frame.origin.y = position.y  - _frame.size.height;
                break;
            case MonsterAlignType.TOP_RIGHT:
                _frame.origin.x = position.x - _frame.size.width;
                _frame.origin.y = position.y  - _frame.size.height;
                break;
            case MonsterAlignType.CENTER:
                _frame.origin.x = position.x - _frame.size.width/2.0;
                _frame.origin.y = position.y - _frame.size.height/2.0;
                break;
            
            case MonsterAlignType.CENTER_LEFT:
                _frame.origin.x = position.x;
                _frame.origin.y = position.y - _frame.size.height/2.0;
                break;
            
            case MonsterAlignType.CENTER_RIGHT:
                _frame.origin.x = position.x - _frame.size.width;
                _frame.origin.y = position.y - _frame.size.height/2.0;
                break;
            case MonsterAlignType.BOTTOM:
                _frame.origin.x = position.x - _frame.size.width/2.0;
                _frame.origin.y = position.y;
                break;
            
            case MonsterAlignType.BOTTOM_RIGHT:
                _frame.origin.x = position.x - _frame.size.width;
                _frame.origin.y = position.y;
                break;
            default:
                //左下角对齐
                _frame.origin.x = position.x;
                _frame.origin.y = position.y;
                break;
        }
        bitmap?.drawInRect(_frame, fromRect: bitmapRect!, operation: NSCompositingOperation.CompositeSourceOver, fraction: 1, respectFlipped: true, hints: nil);
//        bitmap?.drawInRect(_frame, fromRect: bitmapRect!, operation: NSCompositingOperation.CompositeScreen, fraction: 1, respectFlipped: true, hints: nil);
        //CGContextDrawImage(ctx, _frame, bitmap?.CGImage);
    }
    
    /**
     点检测
     */
    public func hitTestPoint(targetP:CGPoint)->Bool
    {
        return false;
    }
    
    /**
     物体碰撞检测
     */
    public func hitTestObject(obj:GMLMonster)->Bool
    {
        return false;
    }
    
}

