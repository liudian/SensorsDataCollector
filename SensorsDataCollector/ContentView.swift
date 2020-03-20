//
//  ContentView.swift
//  SensorsDataCollector
//
//  Created by 刘典 on 2020/3/14.
//  Copyright © 2020 刘典. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {
    @State private var dates = [Date]()
    @State private var collectDataViewPresented = false

    var body: some View {
        NavigationView {
            SensorsDataListView(dates: $dates)
                .navigationBarTitle(Text("采样列表"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                            self.collectDataViewPresented = true
                        }
                    ) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: self.$collectDataViewPresented) {
                        CollectDataView()
                    }
                )
            SensorsDataView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct SensorsDataListView: View {
    @Binding var dates: [Date]

    var body: some View {
        List {
            ForEach(dates, id: \.self) { date in
                NavigationLink(
                    destination: SensorsDataView(selectedDate: date)
                ) {
                    Text("\(date, formatter: dateFormatter)")
                }
            }.onDelete { indices in
                indices.forEach { self.dates.remove(at: $0) }
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

struct CollectDataView: View {
    var body: some View {
        Text("Hello View")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
