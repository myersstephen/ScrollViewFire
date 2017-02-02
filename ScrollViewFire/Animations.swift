//
//  Animations.swift
//  WYFISA
//
//  Created by Tommie McAfee on 7/15/16.
//  Copyright © 2016 RISE & RUN LLC. All rights reserved.
//

import Foundation
import UIKit

class Timing {
    class func runAfter(_ ts: Double, block: @escaping ()->()){
        let delayTime = DispatchTime.now() + Double(Int64(ts * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: block)
    }
    class func runAfterBg(_ ts: Double, block: @escaping ()->()){
        let asyncQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background);
        let delayTime = DispatchTime.now() + Double(Int64(ts * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        asyncQueue.asyncAfter(deadline: delayTime, execute: block)
    }
}

class Animations {
    
    
    class func start(_ duration: TimeInterval, animations: @escaping ()->Void){
        UIView.animate(withDuration: duration, animations: animations)
    }
    
    class func startAfter(_ ts: Double, forDuration duration: TimeInterval, animations: @escaping ()->Void){
        Timing.runAfter(ts){
            self.start(duration, animations: animations)
        }
    }
    class func fadeInOut(_ tsFadeIn: TimeInterval, tsFadeOut: TimeInterval, view: UIView, alpha: CGFloat) {

        if view.alpha != 0.0 {
            return // already transitioning
        }
        
        Animations.start(tsFadeIn){
            view.alpha = alpha
        }
        
        Animations.startAfter(tsFadeIn,
                              forDuration: tsFadeOut){
            view.alpha = 0
        }
        
    }
    class func fadeOutIn(_ tsFadeIn: TimeInterval, tsFadeOut: TimeInterval, view: UIView, alpha: CGFloat) {
        
        if view.alpha != 1.0 {
            return // already transitioning
        }
        
        Animations.start(tsFadeIn){
            view.alpha = alpha
        }
        
        Animations.startAfter(tsFadeIn,
                              forDuration: tsFadeOut){
                                view.alpha = 1
        }
        
    }
}
