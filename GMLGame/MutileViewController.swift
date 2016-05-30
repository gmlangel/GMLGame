//
//  MutileViewController.swift
//  GMLGame
//
//  Created by guominglong on 16/4/27.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
class MutileViewController:NSViewController {
    var btns:[NSButton]!;
    override func viewDidLoad() {
        super.viewDidLoad();
        btns = [];
        var trect:NSRect = NSRect(x: 0, y: 0, width: 100, height: 30);
        for(var i:Int = 0;i<5;i++)
        {
            trect.origin.x = CGFloat(i % 4) * 100;
            trect.origin.y = CGFloat(Int(i/4)) * 30;
            let b:NSButton = NSButton(frame: trect);
            b.title = "第\(i)按钮";
            b.bezelStyle = .RoundedBezelStyle
            b.bordered = true;
            self.view.addSubview(b);
            b.target = self;
            b.action = Selector("onbtnclick:");
        }
        
    }
    
    func onbtnclick(sender:NSButton)
    {
        let arr = NSApplication.sharedApplication().windows;
        for(var i:Int = 1 ;i<arr.count; i++)
        {
            let win = arr[i];
            win.contentViewController?.dismissViewController(win.contentViewController!);
        }
        let vc:NSViewController = (self.storyboard?.instantiateControllerWithIdentifier("childViewCon")) as! NSViewController;
        vc.view.wantsLayer = true;
        self.presentViewController(vc, animator: MyAni())
        
        vc.view.layer?.backgroundColor = NSColor(white: 0xff6600, alpha: 1).CGColor;
        
        self.view.window?.addChildWindow(NSWindow(contentViewController: vc), ordered: NSWindowOrderingMode.Above);
    }
    
   
    
    
}

class MyAni:NSObject,NSViewControllerPresentationAnimator {
    
    func animatePresentationOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        let b:NSWindow = NSWindow(contentViewController: viewController);
        fromViewController.view.window?.addChildWindow(b, ordered: NSWindowOrderingMode.Above)
    }
    func animateDismissalOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        fromViewController.view.window?.removeChildWindow(viewController.view.window!);
        
    }
}