//
//  SceneDelegate.swift
//  SensorsDataCollector
//
//  Created by 刘典 on 2020/3/14.
//  Copyright © 2020 刘典. All rights reserved.
//

import UIKit
import SwiftUI
import WatchConnectivity

class SceneDelegate: UIResponder, UIWindowSceneDelegate, WCSessionDelegate {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WCSession active", Thread.current.isMainThread)
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession deactivate")
    }
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        guard file.metadata != nil else {
            print("file.metadata is nil")
            return
        }
        guard file.metadata!["dir"] != nil && file.metadata!["filename"] != nil else {
            print(" invalid metadata \(file.metadata!)")
            return
        }
        print("receive file: \(file.fileURL) metadata: \(file.metadata!)")
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let dataFilesDir = docDir.appendingPathComponent(file.metadata!["dir"] as! String)
        print("dataFilesDir: \(dataFilesDir)")
        if !FileManager.default.fileExists(atPath: dataFilesDir.path) {
            do {
                
                try FileManager.default.createDirectory(at: dataFilesDir, withIntermediateDirectories: true)
                
            }
            catch {
                print("create dir error: \(error)")
                return
            }
        }
        let dataFile = dataFilesDir.appendingPathComponent(file.metadata!["filename"] as! String)
        try! FileManager.default.moveItem(at: file.fileURL, to: dataFile)
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let object = message["imuData"] {
            let imuData = try? SensorsDataCollector_IMUData(serializedData: object as! Data)
            guard imuData != nil else {
                print("imuData is nil")
                return
            }
            didReceiveIMUData(imuData!)
        }
        
    }
    private func didReceiveIMUData(_ imuData: SensorsDataCollector_IMUData) {
        DispatchQueue.main.async {
            self.model.imuData = imuData
        }
    }
    
    var window: UIWindow?
    var model = Model()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("scene connect", Thread.current.isMainThread)
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        assert(WCSession.isSupported(), "requires Watch Connectivity support!")
        WCSession.default.delegate = self
        WCSession.default.activate()
        
        // Remind the setup of WatchSettings.sharedContainerID.
        //
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(model: model)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("scene disconnect")
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("scene become active")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("scene resign active")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("scene foreground")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("scene background")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

