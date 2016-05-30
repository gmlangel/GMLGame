//  具有行动能力的物体
//  Monster.swift
//  GMLGame
//
//  Created by guominglong on 16/1/18.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import AppKit
public class Monster:GMLObject{
    
    /**
     物体名称标识
     */
    public var nameKey:String!;
    
    /**
     位置
     */
    public var position:NSPoint!;
    /**
     帧动画
     */
    public var bitmapAniArray:[NSBitmapImageRep]!;
    
    /**
     是否初始化完毕
     */
    public var isInited:Bool! = false;
    
    
    public var align:MonsterAlignType! = MonsterAlignType.CENTER;
    public override init() {
        super.init();
    }
    
    
    
    /**
     通过复制创建新的副本
     */
    public func copyToNewMonster()->Monster{
        return Monster();
    }
}

/**
 对齐方式
 */
public enum MonsterAlignType{
    /**
    左上角对齐
    */
    case TOP_LEFT
    
    /**
    居中上对齐
    */
    case TOP
    
    /**
    右上角对齐
    */
    case TOP_RIGHT
    
    /**
    垂直，水平居中
    */
    case CENTER
    
    /**
    左下角对齐
    */
    case BOTTOM_LEFT
    
    /**
    居中下对齐
    */
    case BOTTOM
    
    /**
    右下角对齐
    */
    case BOTTOM_RIGHT
}