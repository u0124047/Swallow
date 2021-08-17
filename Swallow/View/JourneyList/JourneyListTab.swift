//
//  JourneyListTab.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI

struct JourneyListTab: View {
    var dict: [String: [Journey]] = [:]
    var body: some View {
        ZStack {
            Color.blueColor.edgesIgnoringSafeArea(.all)
            List {
                ForEach(dict.sorted { $0.0 < $1.0 }, id: \.key) { key, value in
                    Section(header: Text(key)) {
                        ForEach(value, id: \.id){ j in
                            JourneyLargeCell(journey: j)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = 0
            })
        }
        .navigationBarHidden(true)
    }
}
