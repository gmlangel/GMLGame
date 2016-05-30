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
        self.contentsScale = (NSScreen.mainScreen()?.backingScaleFactor)!;
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    public override func drawInContext(ctx: CGContext) {
        //let context = NSGraphicsContext.currentContext();
        //NSGraphicsContext.setCurrentContext(NSGraphicsContext(CGContext: ctx, flipped: false));
        //super.drawInContext(ctx);
        for mon in monters
        {
            mon.update();
            mon.drawToCGContext(ctx);
        }
       // NSGraphicsContext.setCurrentContext(context);
    }
    
    /**
     添加一个动画物体
     */
    public func addMonter(mon:GMLMonster)
    {
        monters.append(mon);

        
    }
}