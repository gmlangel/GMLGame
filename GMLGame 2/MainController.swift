//
//  MainController.swift
//  GMLGame
//
//  Created by guominglong on 16/1/8.
//  Copyright © 2016年 guominglong. All rights reserved.
//

import Foundation
import Cocoa
@available(OSX 10.10, *)
class MainController:NSWindowController,NSWindowDelegate{

    override func windowDidLoad() {
        self.window?.delegate = self;
       // NSApplication.sharedApplication().delegate = self;
        
    }
    
    func windowShouldClose(sender: AnyObject) -> Bool {
        NSApplication.sharedApplication().stopModalWithCode(1)
        NSApplication.sharedApplication().terminate(nil);
        return true;
    }
    
}