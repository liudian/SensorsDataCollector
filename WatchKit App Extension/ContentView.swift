//
//  ContentView.swift
//  WatchKit App Extension
//
//  Created by 刘典 on 2020/3/14.
//  Copyright © 2020 刘典. All rights reserved.
//

import SwiftUI
class Model: ObservableObject, CollectorDelegate{
    private let collector: Collector
    init() {
        collector = Collector()
        collector.delegate = self
    }
    @Published var started: Bool = false
    func didStart() {
        started = true
    }
    
    func didStop() {
        started = false
    }
    func start() {
        collector.start()
    }
    func stop() {
        collector.stop()
    }
    
    
}
struct ContentView: View {
    @ObservedObject var model: Model
    var body: some View {
        Group {
            Text(model.started ? "正在采集数据…" : "按压屏幕打开菜单")
                .foregroundColor(model.started ? .red : nil)
        }
        .contextMenu(menuItems: {
            Button(action: {
                self.model.start()
            }) {
               VStack{
                Image(systemName: "play")
                        .font(.title)
                    Text("开始")
                }
            }
            Button(action: {
                self.model.stop()
            }) {
               VStack{
                    Image(systemName: "stop")
                        .font(.title)
                    Text("停止")
                }
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
