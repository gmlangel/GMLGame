//
//  GMLEnums.swift
//  GMLGame
//
//  Created by guominglong on 16/1/19.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
/**
 动画类型
 */
public class GMLAniType{
    
    /**
     默认状态
     */
    public static let DEFAULT:String =  "ANI_DEFAULT"
    
    /**
     向左移动
     */
    public static let MOVE_LEFT:String =  "ANI_MOVE_LEFT"
    
    /**
     向左上移动
     */
    public static let MOVE_TOP_LEFT:String =  "ANI_MOVE_TOP_LEFT"
    
    /**
     向左下移动
     */
    public static let MOVE_BOTTOM_LEFT:String =  "ANI_MOVE_BOTTOM_LEFT"
    
    
    /**
     向上移动
     */
    public static let TOP:String = "ANI_TOP";
    
    /**
     向下移动
     */
    public static let BOTTOM:String = "ANI_BOTTOM";
    
    
    /**
     向右移动
     */
    public static let MOVE_RIGHT:String =  "ANI_MOVE_RIGHT"
    
    /**
     向右上移动
     */
    public static let MOVE_TOP_RIGHT:String =  "ANI_MOVE_TOP_RIGHT"
    
    /**
     向右下移动
     */
    public static let MOVE_BOTTOM_RIGHT:String =  "ANI_MOVE_BOTTOM_RIGHT"
    
    /**
     攻击
     */
    public static let ATTACK:String = "ANI_ATTACK"
    
    /**
     发动技能
     */
    public static let MAGIC:String = "ANI_MAGIC";
    
    public init(){
        
    }
}

/**
 对齐方式
 */
public class MonsterAlignType{
    /**
     左上角对齐
     */
    public static let TOP_LEFT:String = "TOP_LEFT"
    
    /**
     居中上对齐
     */
    public static let TOP:String = "TOP"
    
    /**
     右上角对齐
     */
    public static let TOP_RIGHT:String = "TOP_RIGHT"
    
    /**
     垂直，水平居中
     */
    public static let CENTER:String = "CENTER"
    
    /**
     垂直居中左对齐
     */
    public static let CENTER_LEFT:String = "CENTER_LEFT";
    
    /**
     垂直居中右对齐
     */
    public static let CENTER_RIGHT:String = "CENTER_RIGHT";
    
    /**
     左下角对齐
     */
    public static let BOTTOM_LEFT:String = "BOTTOM_LEFT"
    
    /**
     居中下对齐
     */
    public static let BOTTOM:String = "BOTTOM"
    
    /**
     右下角对齐
     */
    public static let BOTTOM_RIGHT:String = "BOTTOM_RIGHT"
    
    
    
}