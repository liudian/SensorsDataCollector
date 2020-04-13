//
//  Collector.swift
//  WatchKit App Extension
//
//  Created by 刘典 on 2020/4/1.
//  Copyright © 2020 刘典. All rights reserved.
//

import Foundation
import AVFoundation
import WatchConnectivity
import CoreMotion
import HealthKit
protocol CollectorDelegate: class {
    func didStart()
    func didStop()
}
class Collector: NSObject, AVAudioRecorderDelegate, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard message["command"] != nil else {
            return
        }
        if message["command"] as! String == "begin" {
            markLabelBegin(message["label"] as! String)
        }
        else if message["command"] as! String == "end" {
            markLabelEnd()
        }
    }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    let setting : [String:Any] =
        [
            AVFormatIDKey:kAudioFormatMPEG4AAC,
            AVSampleRateKey:8000.0,
            AVNumberOfChannelsKey:1,
            AVEncoderBitDepthHintKey:16
    ]
    private var started: Bool = false
    private var dataDir: String?
    private var tempDirURL: URL?
    private var imuSampler: SensorsDataCollector_IMUSampler?
    private var dataLabels: SensorsDataCollector_DataLabels?
    private var currentLabel: SensorsDataCollector_Label?
    private var audioRecorder: AVAudioRecorder?
    
    private let motionManager = CMMotionManager()
    private let healthStore = HKHealthStore()
    private var session: HKWorkoutSession?
    private let queue = OperationQueue()
    weak var delegate: CollectorDelegate?
    
    private func markLabelBegin(_ label: String) {
        guard started else {
            return
        }
        print("mark label begin: \(label)")
        currentLabel = SensorsDataCollector_Label()
        currentLabel!.label = label
        currentLabel!.audioBegin = Float(audioRecorder!.currentTime)
        currentLabel!.imuBegin = Int32(imuSampler!.data.endIndex)
    }
    private func markLabelEnd() {
        guard started && currentLabel != nil else {
            return
        }
        print("mark label end")
        currentLabel!.audioEnd = Float(audioRecorder!.currentTime)
        currentLabel!.imuEnd = Int32(imuSampler!.data.endIndex) + 1
        dataLabels!.labels.append(currentLabel!)
        currentLabel = nil
    }
    private func startAudioRecord() {
        guard audioRecorder == nil else {
            return
        }
        try! AVAudioSession.sharedInstance().setCategory(.record)
        try! AVAudioSession.sharedInstance().setActive(true)
        let audioFileURL = tempDirURL!.appendingPathComponent("audio.m4a")
        try! audioRecorder = AVAudioRecorder(url: audioFileURL, settings: setting)
        audioRecorder?.delegate = self
        audioRecorder!.record()
        
        
    }
    private func stopAudioRecord() {
        guard audioRecorder != nil else {
            return
        }
        audioRecorder!.stop()
        
    }
    private func startMotion() {
        guard session == nil else {
            return
        }
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .tennis
        workoutConfiguration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
        } catch {
            fatalError("Unable to create the workout session!")
        }
        session!.startActivity(with: Date())
        
        
        
        imuSampler!.samplingRate = 50
        motionManager.deviceMotionUpdateInterval = 1.0/Double(imuSampler!.samplingRate)
        motionManager.startDeviceMotionUpdates(to: queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            guard error == nil else {
                NSLog("Encountered error: \(error!)")
                return
            }
            
            guard deviceMotion != nil else {
                NSLog("device Motion is nil")
                return
            }
            var imuData = SensorsDataCollector_IMUData()
            let g = deviceMotion!.gravity
            let a = deviceMotion!.userAcceleration
            let r = deviceMotion!.rotationRate
            imuData.acceleration.x = Float(a.x)
            imuData.acceleration.y = Float(a.y)
            imuData.acceleration.z = Float(a.z)
            imuData.gravity.x = Float(g.x)
            imuData.gravity.y = Float(g.y)
            imuData.gravity.z = Float(g.z)
            imuData.rotationRate.x = Float(r.x)
            imuData.rotationRate.y = Float(r.y)
            imuData.rotationRate.z = Float(r.z)
            self.imuSampler!.data.append(imuData)
            if WCSession.default.isReachable  {
                
                if self.imuSampler!.data.count % Int(self.imuSampler!.samplingRate) == 0 {
                    NSLog("send imu data")
                    do {
                        WCSession.default.sendMessage(["imuData": try imuData.serializedData()], replyHandler: nil)
                    }
                    catch {
                        print("send imu data error: \(error)")
                    }
                }
                
            } else {
                print("not reachable!")
            }
            
            
            
            
        }
        
    }
    private func stopMotion() {
        guard session != nil else {
            return
        }
        motionManager.stopDeviceMotionUpdates()
        session!.end()
        session = nil
    }
    
    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
        WCSession.default.delegate = self
        
    }
    func start() {
        guard !started else {
            return
        }
        dataDir = dateFormatter.string(from: Date())
        
        tempDirURL = FileManager.default.temporaryDirectory.appendingPathComponent(dataDir!)
        print("tempURL: \(tempDirURL!)")
        do {
            try FileManager.default.createDirectory(at: tempDirURL!, withIntermediateDirectories: true)
        } catch {
            print("create temp dir error: \(error)")
            return
        }
        
        imuSampler = SensorsDataCollector_IMUSampler()
        dataLabels = SensorsDataCollector_DataLabels()
        startAudioRecord()
        startMotion()
        started = true
        delegate?.didStart()
    }
    func stop() {
        guard started else {
            return
        }
        
        stopMotion()
        stopAudioRecord()
        
        let imuSamplerData = try! imuSampler!.serializedData()
        let imuSamplerURL = tempDirURL!.appendingPathComponent("imu.protobuf")
        try! imuSamplerData.write(to: imuSamplerURL)
        WCSession.default.transferFile(imuSamplerURL, metadata: ["dir": dataDir!, "filename": "imu.protobuf"])
        imuSampler = nil
        let dataLabelsData = try! dataLabels!.serializedData()
        let dataLabelsURL = tempDirURL!.appendingPathComponent("labels.protobuf")
        try! dataLabelsData.write(to: dataLabelsURL)
        WCSession.default.transferFile(dataLabelsURL, metadata: ["dir": dataDir!, "filename": "labels.protobuf"])
        dataLabels = nil
        currentLabel = nil
        
        
        
        
        started = false
        delegate?.didStop()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("did finish recording")
            WCSession.default.transferFile(recorder.url, metadata: ["dir": dataDir!, "filename": "audio.m4a"])
            
        }
        try! AVAudioSession.sharedInstance().setActive(false)
        audioRecorder = nil
        started = false
        delegate?.didStop()
    }
}
