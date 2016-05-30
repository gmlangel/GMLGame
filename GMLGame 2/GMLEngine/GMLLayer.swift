//
//  GMLLayer.swift
//  GMLGame
//
//  Created by guominglong on 16/1/20.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
public class GMLLayer:CALayer{
    public var monters:[GMLMonster]!;
    override init() {
        super.init();
        monters = [];
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    public override func drawInContext(ctx: CGContext) {
        let context = NSGraphicsContext.currentContext();
        NSGraphicsContext.setCurrentContext(NSGraphicsContext(CGContext: ctx, flipped: false));
        super.drawInContext(ctx);
        for mon in monters{
            mon.update();//更新动物的当前状态
            mon.drawToCGContext(ctx);//将动物绘制到本图层
        }
        NSGraphicsContext.setCurrentContext(context);
    }
    
    /**
     添加一个动画物体
     */
    public func addMonter(mon:GMLMonster)
    {
        monters.append(mon);
    }
}