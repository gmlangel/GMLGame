//
//  ViewController.swift
//  GMLGame
//
//  Created by guominglong on 16/1/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Cocoa
import Metal
import Quartz
import MetalKit
@available(OSX 10.10, *)
class ViewController: NSViewController {

    var btn_save:NSButton!;
    var tv:tView!;
    var fr:FileReader!;
    var aniLayer:GMLLayer!;
    var openView:OpenView!;
    var imgs:[NSImageView]!;
    var beImg:[NSImage]!;
    var currentI:Int = 0;
    var tbmp:NSBitmapImageRep!;
    
    var device:MTLDevice!;
    var metalLayer:CAMetalLayer!;
    var vertextBuffer:MTLBuffer! = nil;
    override func viewDidLoad() {
        
        super.viewDidLoad();
//        imgs = [];
//        for(var i:Int = 0;i<100;i++)
//        {
//            //NSRect(x: CGFloat(rand()%Int32(self.view.frame.size.width)), y: CGFloat(rand()%Int32(self.view.frame.size.height)), width: 100, height: 200)
//            //NSRect(x: 0, y: 0, width: 100, height: 200)
//            let img:NSImageView = NSImageView(frame: NSRect(x: CGFloat(rand()%Int32(self.view.frame.size.width)), y: CGFloat(rand()%Int32(self.view.frame.size.height)), width: 100, height: 200));
//            imgs.append(img);
//            img.imageScaling = NSImageScaling.ScaleNone;
//            img.imageAlignment = NSImageAlignment.AlignCenter;
//            self.view.addSubview(img);
//        }
//        GMLDataResourceManager.instance.addResourceByLocalPath("bbb", path: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/xiaoshi.png")
//        GMLDataResourceManager.instance.addResourceByLocalPath("ccc", path: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/siwang.png")
//        beImg = [];
//        beImg.append(NSImage(data: GMLDataResourceManager.instance.getNSDataByName("bbb")!)!)
//        beImg.append(NSImage(data: GMLDataResourceManager.instance.getNSDataByName("ccc")!)!)
//        
//        
//        GMLImageManager.instance.loadImgForKeyByLocalPath("mytest", bitmapPath: "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/xiaoshi.png");
//        tbmp = GMLImageManager.instance.getImgForKey("mytest");
//        NSTimer.scheduledTimerWithTimeInterval(1.0/30, target: self, selector: Selector("fileImage"), userInfo: nil, repeats: true)
//        return;

       // startfunc1();
       // startfunc2();
        
        //startMetal();
     
       // let mtlDevice:MTLDevice = MTLCreateSystemDefaultDevice()!;
        //let mtkview:MTKView = MTKView(frame: self.view.frame, device: mtlDevice);
        
        
    }
    
    
    
    private func startMetal()
    {
        self.view.wantsLayer = true;
        device = MTLCreateSystemDefaultDevice();
        
        metalLayer = CAMetalLayer();
        metalLayer.device = device;
        metalLayer.pixelFormat = .BGRA8Unorm;
        metalLayer.framebufferOnly = true;
        metalLayer.frame = self.view.frame;
        self.view.layer?.addSublayer(metalLayer);
        
        
        //开始绘制图形
        let vertexData:[Float] = [
            0.0,1.0,0.0,
            -1.0,-1.0,0.0,
            1.0,-1.0,0.0
        ]
        
        vertextBuffer = device.newBufferWithBytes(vertexData, length: vertexData.count * sizeofValue(vertexData[0]), options: MTLResourceOptions.CPUCacheModeDefaultCache);
    }
    
    //openGL
    func startfunc2()
    {
        //初始化主入口，并运行
        let start:Starter = Starter();
        start.start();
        
        openView = OpenView(frame: self.view.frame, pixelFormat: nil);
        //添加渲染图层
        GMLRenderManager.instance.addRenderView(openView);
        
        
        let size:CGSize = self.view.frame.size;
        //创建1个monster动物，并添加到动画图层
        for(var i:Int = 0;i<1000;i++)
        {
            let mon:GMLMonster? = GMLFactoryManager.instance.getMonster("FirstMonster");
            //mon?.position = CGPoint(x: size.width/2.0, y: size.height/2.0);
            mon?.position = CGPoint(x: CGFloat(rand()%Int32(size.width))+30, y: CGFloat(rand()%Int32(size.height)));
            openView.addMonter(mon!);
        }
        
        //添加动画图层到显示窗口
        openView.needsDisplay = true;
        self.view.addSubview(openView);
        
        
        //添加测试按钮
        var btn:NSButton = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 40));
        btn.title = GMLAniType.DEFAULT;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick2:");
        
        btn = NSButton(frame: NSRect(x: 0, y: 50, width: 100, height: 40));
        btn.title = GMLAniType.ATTACK;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick2:");
        
        btn = NSButton(frame: NSRect(x: 0, y: 100, width: 100, height: 40));
        btn.title = GMLAniType.MAGIC;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick2:");
    }
    
    //layer
    func startfunc1()
    {
        //初始化主入口，并运行
        let start:Starter = Starter();
        start.start();
        
        //添加渲染图层
        aniLayer = GMLLayer();
        aniLayer.backgroundColor = CGColorCreateGenericRGB(1, 0, 0, 0.5);
        start.addRenderLayer(aniLayer);
        
        
        let size:CGSize = self.view.frame.size;
        //创建1个monster动物，并添加到动画图层
        for(var i:Int = 0;i<1000;i++)
        {
            let mon:GMLMonster? = GMLFactoryManager.instance.getMonster("FirstMonster");
            //mon?.position = CGPoint(x: size.width/2.0, y: size.height/2.0);
            mon?.position = CGPoint(x: CGFloat(rand()%Int32(size.width))+30, y: CGFloat(rand()%Int32(size.height)));
            aniLayer.addMonter(mon!);
        }
        
        //添加动画图层到显示窗口
        self.view.wantsLayer = true;
        self.view.layer?.addSublayer(aniLayer);
        aniLayer.frame = self.view.frame;
        
        
        //添加测试按钮
        var btn:NSButton = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 40));
        btn.title = GMLAniType.DEFAULT;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick:");
        
        btn = NSButton(frame: NSRect(x: 0, y: 50, width: 100, height: 40));
        btn.title = GMLAniType.ATTACK;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick:");
        
        btn = NSButton(frame: NSRect(x: 0, y: 100, width: 100, height: 40));
        btn.title = GMLAniType.MAGIC;
        self.view.addSubview(btn);
        btn.target = self;
        btn.action = Selector("onbtnclick:");
    }
    
    
    func fileImage()
    {
        if(currentI + 1 == beImg.count)
        {
            currentI = 0;
        }else{
            currentI++;
        }
        for imgV in imgs
        {
            imgV.image = beImg[currentI];
            //var bmp:NSBitmapImageRep = getbmp();
        }

        
    }
    
    func getbmp() ->NSBitmapImageRep
    {
        return tbmp;
    }
    
    func onbtnclick(sender:AnyObject)
    {
        let aniType:String = (sender as! NSButton).title;
        for mon in aniLayer.monters
        {
            mon.aniType = aniType;
           // mon.isLoopAni = false;
        }
    }
    
    
    func onbtnclick2(sender:AnyObject)
    {
        let aniType:String = (sender as! NSButton).title;
        for mon in openView.monters
        {
            mon.aniType = aniType;
            // mon.isLoopAni = false;
        }
    }
    
    func fileLoadend(e:GMLEvent)
    {
        NSLog("加载完毕");
        fr.removeEventListener(GMLEventType.COMPLETE);
        fr.removeEventListener(GMLEventType.PROGRESS);

    }
    
    func onfileLoadProgress(e:GMLEvent)
    {
        NSLog("加载进度:\(e.loadedBytes/e.totalBytes)");
    }
    
    
    func tosave(sender:AnyObject)
    {
        
        
        
        let bmp:NSBitmapImageRep = tv.getBmp();
        let nd:NSData = bmp.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [NSImageGamma:1])!;
        nd.writeToFile("test.png", atomically: true);
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidAppear() {
        
    }
    
    

}

