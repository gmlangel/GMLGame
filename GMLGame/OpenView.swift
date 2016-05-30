//
//  OpenView.swift
//  GMLGame
//
//  Created by guominglong on 16/1/22.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class OpenView:NSOpenGLView{
    public var monters:[GMLMonster]!;
    private var canvas:CGContextRef?;
    public override init?(frame frameRect: NSRect, pixelFormat format: NSOpenGLPixelFormat?) {
        super.init(frame: frameRect, pixelFormat: format);
        monters = [];
    }
    public func addMonter(mon:GMLMonster)
    {
        monters.append(mon);
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    
    public override func drawRect(dirtyRect: NSRect) {
        canvas = NSGraphicsContext.currentContext()?.CGContext;
        for mon in monters{
            mon.update();//更新动物的当前状态
            mon.drawToCGContext(canvas!);//将动物绘制到本图层
        }
        super.drawRect(dirtyRect);
    }
}