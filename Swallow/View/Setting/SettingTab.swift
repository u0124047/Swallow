//
//  SettingTab.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI

struct SettingTab: View {
    let settings = ["管理寶寶", "管理行程類別", "切換語言"]
    var body: some View {
        VStack {
            List(settings, id: \.self) { setting in
                Text(setting)
                    .frame(height: 44)
            }
            .navigationBarTitle("設定")
            .listStyle(GroupedListStyle())
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
            })
        }
    }
}

