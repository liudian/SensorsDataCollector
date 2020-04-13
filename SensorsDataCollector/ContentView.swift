//
//  ContentView.swift
//  SensorsDataCollector
//
//  Created by 刘典 on 2020/3/14.
//  Copyright © 2020 刘典. All rights reserved.
//

import SwiftUI
import WatchConnectivity
var nextId: Int = 1000

class Model: ObservableObject {
    @Published var dataList: [Int] = []
    @Published var imuData = SensorsDataCollector_IMUData()
    @Published var selectedLabel: String = "" {
        didSet {
            if selectedLabel != "" {
                print("begin label")
                WCSession.default.sendMessage(["command": "begin", "label": selectedLabel], replyHandler: nil)
                
            } else {
                print("end label")
                WCSession.default.sendMessage(["command": "end"], replyHandler: nil)
                
            }
        }
    }
    @Published var processing = false
    
    
    
    init() {
        
    }
    
    
}

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()
/*
struct ContentView: View {
    @State private var dates = [Date]()
    @State private var collectDataViewPresented = false
    @ObservedObject var model: Model
    var body: some View {
        NavigationView {
            SensorsDataListView(model:model)
                .navigationBarTitle(Text("数据列表"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                            self.collectDataViewPresented = true
                    }
                    ) {
                        Text(" + ").font(.title)
                    }.sheet(isPresented: self.$collectDataViewPresented) {
                        CollectDataView(model: self.model)
                    }
            )
            SensorsDataView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
*/
struct ContentView: View {
    @State private var dates = [Date]()
    @State private var collectDataViewPresented = false
    @ObservedObject var model: Model
    var body: some View {
        NavigationView {
            CollectDataView(model: self.model)
                .navigationBarTitle(Text("数据采集"))
                
            SensorsDataView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
struct SensorsDataListView: View {
    
    @ObservedObject var model: Model
    var body: some View {
        List {
            ForEach(model.dataList, id: \.self) { id in
                NavigationLink(
                    destination: SensorsDataView()
                ) {
                    Text("\(id)")
                }
            }.onDelete { indices in
                indices.forEach { self.model.dataList.remove(at: $0) }
            }
        }
    }
}

struct SensorsDataView: View {
    var selectedDate: Date?
    
    var body: some View {
        Group {
            if selectedDate != nil {
                Text("\(selectedDate!, formatter: dateFormatter)")
            } else {
                Text("Detail view content goes here")
            }
        }.navigationBarTitle(Text("Detail"))
    }
}

struct Vector3fView: View {
    let label: String
    let vector3f: SensorsDataCollector_Vector3f
    var body:some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(label):").frame(alignment:.leading)
                .font(.subheadline).foregroundColor(.gray)
            Text(String(format: "%.2lf, %.2lf, %.2lf",
                        arguments:[vector3f.x, vector3f.y, vector3f.z]))
                .font(.headline)
                .frame(maxWidth:.infinity, alignment: .trailing)
            
            
            
            
        }
    }
}
struct IMUDataView: View {
    let imuData: SensorsDataCollector_IMUData
    var body:some View {
        VStack(spacing: 8) {
            Vector3fView(label: "加速度", vector3f: imuData.acceleration)
            Vector3fView(label: "重力", vector3f: imuData.gravity)
            Vector3fView(label: "角速度", vector3f: imuData.rotationRate)
        }.padding(12)
    }
}
struct SelectedButton: View {
    let text: String
    let selected: Bool
    let action: ()-> Void
    
    var body: some View {
        Button(action: self.action) {
            Text(self.text).foregroundColor(self.selected ? .white : .blue).padding(8).frame(maxWidth: .infinity).background(self.selected ? Color.blue : Color.black.opacity(0)).cornerRadius(8).overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1))
        }
    }
}

struct LabelButton: View {
    let text: String
    @ObservedObject var model: Model
    var body: some View {
        SelectedButton(text:self.text, selected: self.text == self.model.selectedLabel) {
            if self.model.selectedLabel == self.text {
                self.model.selectedLabel = ""
            }
            else if self.model.selectedLabel == "" {
                self.model.selectedLabel = self.text
            }
        }
    }
}
/*
 1 上左外 2 上左中 3 上左内
 4 上前外 5 上前内 6 上有内
 7 上右中 8 上右内 9 下左外
 10 下左中 11 下左内 12 下前外
 13 下前内 14 下右外 15 下右中
 16 下右内 17 漱口 18 噪声
 */
struct LabelsView: View {
    @ObservedObject var model: Model
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                LabelButton(text:"上左外", model: model)
                LabelButton(text:"上左中", model: model)
                LabelButton(text:"上左内", model: model)
                
            }
            HStack {
                LabelButton(text:"上前外", model: model)
                LabelButton(text:"上前内", model: model)
                LabelButton(text:"上有内", model: model)
                
            }
            HStack {
                LabelButton(text:"上右中", model: model)
                LabelButton(text:"上右内", model: model)
                LabelButton(text:"下左外", model: model)
                
            }
            
            HStack {
                LabelButton(text:"下左中", model: model)
                LabelButton(text:"下左内", model: model)
                LabelButton(text:"下前外", model: model)
                
            }
            HStack {
                LabelButton(text:"下前内", model: model)
                LabelButton(text:"下右外", model: model)
                LabelButton(text:"下右中", model: model)
                
            }
            HStack {
                LabelButton(text:"下右内", model: model)
                LabelButton(text:"漱口", model: model)
                LabelButton(text:"噪声", model: model)
                
            }
            
        }.padding(12).disabled(model.processing)
            .opacity(model.processing ? 0.5 : 1.0)
    }
}
struct ControlsView: View {
    @ObservedObject var model: Model
    var body: some View {
        Button(action: {
            if self.model.processing {
                self.model.dataList.append(nextId)
                nextId += 1
            }
            self.model.processing.toggle()
            
            
        }){
            Text(model.processing ? "停止" : "开始")
                .font(.title)
                .foregroundColor(.white)
                .frame(width:88, height:88)
                .background(model.selectedLabel=="" ? Color.gray : model.processing ? Color.red : Color.green)
                .cornerRadius(44)
        }.disabled(model.selectedLabel=="")
            .opacity(model.selectedLabel=="" ? 0.5 : 1.0)
    }
}
struct CollectDataView: View {
    @ObservedObject var model: Model
    var body: some View {
        VStack(spacing: 24) {
            IMUDataView(imuData: model.imuData)
            LabelsView(model: model)
            //ControlsView(model: model)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    private static var model = Model()
    static var previews: some View {
        CollectDataView(model: model)
    }
}
