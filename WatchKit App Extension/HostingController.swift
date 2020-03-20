//
//  HostingController.swift
//  WatchKit App Extension
//
//  Created by 刘典 on 2020/3/14.
//  Copyright © 2020 刘典. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import CoreMotion

class HostingController: WKHostingController<ContentView> {
    
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    private func startMotion() {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            guard error == nil else {
                NSLog("Encountered error: \(error!)")
                return
            }

            guard deviceMotion != nil else {
                NSLog("device Motion is nil")
                return
            }
            let g = deviceMotion!.gravity
            let u = deviceMotion!.userAcceleration
            let a = CMAcceleration(x: g.x + u.x, y: g.y + u.y, z: g.z + u.z)
            let r = deviceMotion!.rotationRate
            print(String(format: "acc(%.2lf, %.2lf, %.2lf), rot(%.2lf, %.2lf, %.2lf)",
                         arguments:[a.x, a.y, a.z, r.x, r.y, r.z]))
            
        }
        
    }
    private func stopMotion() {
        motionManager.stopDeviceMotionUpdates()
    }
    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
    }
    override func willActivate() {
        NSLog("HostingController willActivate")
        startMotion()
        
    }
    override func didDeactivate() {
        NSLog("HostingController didDeactivate")
        stopMotion()
    }
    override var body: ContentView {
        return ContentView()
    }
}
