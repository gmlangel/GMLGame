//
//  TestLayer.swift
//  GMLGame
//
//  Created by guominglong on 16/1/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import Cocoa
public class TestLayer:CALayer{

    
    public override func drawInContext(ctx: CGContext) {

        let da:NSData = NSData(contentsOfFile: "GMLGame.app/Contents/Resources/5689c663daa48_1025.png")!
        let img:NSBitmapImageRep = NSBitmapImageRep(data: da)!;
        let imgRef:CGImageRef = img.CGImage!;
        let gw:CGFloat = CGFloat(CGImageGetWidth(imgRef));
        let gh:CGFloat = CGFloat(CGImageGetHeight(imgRef));
        let scale:CGFloat = self.bounds.size.width / gw;
        CGContextTranslateCTM(ctx, 0,0);
        CGContextScaleCTM(ctx, scale,scale);
        CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: gw, height: gh), imgRef);
        
        
    }
}
