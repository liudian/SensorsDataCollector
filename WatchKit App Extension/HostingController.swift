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
    
    
    
    override func willActivate() {
        
        
    }
    override func didDeactivate() {
        
    }
    override var body: ContentView {
        return ContentView(model: Model())
    }
}
