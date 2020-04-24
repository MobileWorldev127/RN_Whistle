//
//  ModuleInitializer.swift
//  imessage.ext
//
//  Created by Admin on 11/26/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

@objc(ModuleInitializer)
class ModuleInitializer: NSObject {
  let messagesVC: MessagesViewController
  
  init(messagesVC: MessagesViewController) {
    self.messagesVC = messagesVC
  }
}

extension ModuleInitializer: RCTBridgeDelegate {
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    let url = RCTBundleURLProvider
      .sharedSettings()?
      .jsBundleURL(forBundleRoot: "index.message", fallbackResource: nil)
    
    return url
  }
  
  func extraModules(for bridge: RCTBridge!) -> [RCTBridgeModule]! {
    var extraModules = [RCTBridgeModule]()
    
    let messagesManager = MessagesManager(messagesVC: self.messagesVC)
    let messagesEventEmitter = MessagesEventEmitter()
    
    self.messagesVC.delegate = messagesEventEmitter
    
    extraModules.append(messagesManager as! RCTBridgeModule)
    extraModules.append(messagesEventEmitter)
    
    return extraModules
  }
}
