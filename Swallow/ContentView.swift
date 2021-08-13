//
//  ContentView.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI

struct ContentView: View {

    @State private var babys: [Baby] = [Baby(name: "myBaby", gender: 1, birth: "2021/05/22".convertToDate(), mom: "Kathy", dad: "Sam")]
    @State private var journeys: [Journey] = testData

    var body: some View {
        TabView {
            homeTab
            journeysTab
            journeyListTab
            settingTab
        }
    }

    private var journeyListTab: some View {
        NavigationView {
            let dict = Dictionary(grouping: journeys, by: {$0.date.convertDateToString()})
            JourneyListTab(dict: dict)
        }
        .tabItem { Label("", systemImage: "text.below.photo") }
    }

    private var homeTab: some View {
        ZStack {
            HomeTab(babys: babys)
        }
        .tabItem { Label("", systemImage: "person") }
    }

    private var journeysTab: some View {
        NavigationView {
            JourneysTab(journeys: $journeys)
        }
        .tabItem { Label("", systemImage: "list.bullet") }
    }

    private var settingTab: some View {
        NavigationView {
            SettingTab()
        }
        .navigationTitle("設定")
        .tabItem { Label("", systemImage: "gearshape") }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
