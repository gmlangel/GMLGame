//
//  tView.swift
//  GMLGame
//
//  Created by guominglong on 16/1/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import Cocoa
public class tView:NSView{
    
    private var isInited:Bool!=false;
    private var imgdATA:NSData!;
    private var ci:CGImageRef!;
    private  var tempnr:NSRect!;
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        
        ginit();
    }
    
    public override func drawRect(dirtyRect: NSRect) {
        
        super.drawRect(dirtyRect);
//        let da:NSData = NSData(contentsOfFile: "GMLGame.app/Contents/Resources/5689c663daa48_1025.png")!
//        let img:NSBitmapImageRep = NSBitmapImageRep(data: da)!;
//        img.drawInRect(NSRect(x: 300, y: 0, width: img.size.width/2.0, height: img.size.height/2.0));
        
        if(isInited == true)
        {
            let canvas:CGContextRef = (NSGraphicsContext.currentContext()?.CGContext)!;
            
            self.layer?.contentsScale = (NSScreen.mainScreen()?.backingScaleFactor)!;
            let tempImg:NSImage = NSImage(named: "5689c663daa48_1024")!;
            
            var nr:NSRect = NSRect(x: 0, y: 0, width: tempImg.size.width, height: tempImg.size.height);
            //tempnr = NSRect(x: 0, y: 0, width: tempImg.size.width/2.0, height: tempImg.size.height/2.0);
            let tempci:CGImageRef = tempImg.CGImageForProposedRect(&nr, context: nil, hints: nil)!;

            ci = CGImageCreateWithImageInRect(tempci, CGRect(x: 0, y: 0, width: 400, height: 200));

            tempnr = NSRect(x: 0, y: 100, width: 200/2.0, height: 100/2.0);
            CGContextDrawImage(canvas, tempnr, ci);
        }
    }
    
    public func getBmp()->NSBitmapImageRep
    {
        self.lockFocus();//锁定tv的显示状态
        let bmp:NSBitmapImageRep = NSBitmapImageRep(focusedViewRect: self.frame)!;
        self.unlockFocus();//解锁tv的显示状态
        return bmp;
    }

    
    private func ginit()
    {
        self.wantsLayer = true;
        //self.layer = CALayer();
        self.layer?.backgroundColor = NSColor.redColor().CGColor;
        //加载一张位图进来
        
        let url:NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: "GMLGame.app/Contents/Resources/5689c663daa48_1025.png"));
        func complete(nu:NSURLResponse?,nd:NSData?,ne:NSError?)->Void
        {
            if(nd != nil)
            {
                
                let imgRep:NSBitmapImageRep = NSBitmapImageRep(data: nd!)!;
                let tempImg:NSImage = NSImage(size: imgRep.size);
                tempImg.addRepresentation(imgRep);
                NSLog("\(NSRect(x: 0, y: 0, width: tempImg.size.width, height: tempImg.size.height))");
                
                
                //let tempImg:NSImage = NSImage(data: nd!)!;
                
                //let tempImg:NSImage = NSImage(contentsOfFile: "GMLGame.app/Contents/Resources/test.png")!;
                let tempIMGView:NSImageView = NSImageView(frame: NSRect(x: 500, y: 0, width: tempImg.size.width/4.0, height: tempImg.size.height/4.0));
                tempIMGView.image = tempImg;
                addSubview(tempIMGView);
            }
        }
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue(), completionHandler: complete);
        
        
        let da:NSData = NSData(contentsOfFile: "GMLGame.app/Contents/Resources/test.png")!
        let da2:NSData = NSData(contentsOfFile: "GMLGame.app/Contents/Resources/5689c663daa48_1024.png")!;
        let img:NSImage = NSImage(size: self.bounds.size);
        
//        imgdATA = img.TIFFRepresentation;
//        var tl:TestLayer = TestLayer();
//        tl.contentsScale = NSScreen.mainScreen()!.backingScaleFactor;
//        //tl.backgroundColor = NSColor.redColor().CGColor;
//        tl.frame = NSRect(x: 0, y: 0, width: img.size.width/2, height: img.size.height/2);
//        self.layer?.addSublayer(tl);
//        tl.setNeedsDisplay();
//        self.layer?.setNeedsDisplay();

        
        
        isInited = true;
        self.setNeedsDisplayInRect(self.bounds);
      
        
       // CGImageSourceCreateImageAtIndex(<#T##isrc: CGImageSource##CGImageSource#>, <#T##index: Int##Int#>, <#T##options: CFDictionary?##CFDictionary?#>)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    
}