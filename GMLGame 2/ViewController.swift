//
//  ViewController.swift
//  GMLGame
//
//  Created by guominglong on 16/1/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Cocoa
@available(OSX 10.10, *)
class ViewController: NSViewController {

    var btn_save:NSButton!;
    var tv:tView!;
    var fr:FileReader!;
    var aniLayer:GMLLayer!;
    override func viewDidLoad() {
        super.viewDidLoad()
//        tv = tView(frame: self.view.bounds);
//        self.view.addSubview(tv);
//
//        
//        
//        
//        
//        btn_save = NSButton(frame: NSRect(x: 20, y: 20, width: 100, height: 40));
//        self.view.addSubview(btn_save);
//        btn_save.wantsLayer = true;
//        btn_save.target = self;
//        btn_save.action = Selector("tosave:");
//        
//        
//        let aniView:ANIView = ANIView(frame: NSRect(x: 0, y: 0, width: 50, height: 50));
//        self.view.addSubview(aniView);
        
//        fr = FileReader();
//        fr.asyncLoadFileByURL(NSURL(string:"http://ac.51talk.com/ac/51Talk-AC.exe")!)
//        fr.addEventListener(GMLEventType.COMPLETE, execFunc: fileLoadend);
//        fr.addEventListener(GMLEventType.PROGRESS, execFunc: onfileLoadProgress);
//        
        
       // ResourceManager.instance?.addResourceByLocalPath("tupian", path: "guidang.zip");
       // ResourceManager.instance?.addResourceByNetURL("51talkAC", url: Tool.getNetFileURL("http://ac.51talk.com/ac/51Talk-AC.exe"));
        
        //初始化主入口，并运行
        let start:Starter = Starter();
        start.start();
        
        //添加渲染图层
        aniLayer = GMLLayer();
        aniLayer.backgroundColor = CGColorCreateGenericRGB(1, 0, 0, 0.5);
        start.addRenderLayer(aniLayer);
        
        
        let size:CGSize = self.view.frame.size;
        //创建1个monster动物，并添加到动画图层
        for(var i:Int = 0;i<100;i++)
        {
            let mon:GMLMonster? = GMLFactoryManager.instance.getMonster("FirstMonster");
            //mon?.position = CGPoint(x: size.width/2.0, y: size.height/2.0);
            mon?.position = CGPoint(x: CGFloat(rand()%Int32(size.width)), y: CGFloat(rand()%Int32(size.height)));
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
    
    func onbtnclick(sender:AnyObject)
    {
        let aniType:String = (sender as! NSButton).title;
        for mon in aniLayer.monters
        {
            mon.aniType = aniType;
            mon.isLoopAni = false;
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

