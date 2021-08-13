//
//  HomeTab.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI

struct HomeTab: View {
    var babys: [Baby] = []
    var body: some View {
        Color.yellowColor.edgesIgnoringSafeArea(.all)
        VStack {
            if let baby = self.babys.first {
                Text(Date().convertDateToString())
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(height: 60)
                VStack {
                    Text(baby.name)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(height: 60)
                    Image("family")
                        .renderingMode(.original)
                    Text(baby.birth.daysBetweenNow().text)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(height: 60)
                        .foregroundColor(Color.darkPurpleColor)
                }
                .frame(width: 300, height: 300)
                .background(Color.white)
                .cornerRadius(10)
                Spacer()
            }
        }
    }
}

