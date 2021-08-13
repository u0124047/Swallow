//
//  JourneyCell.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI

struct JourneyCell: View {
    let journey: Journey
    var body: some View {
        NavigationLink(destination: JourneyDetail(journey: journey)) {
            RoundedRectangle(cornerRadius: 2.5)
                .foregroundColor(journey.date<Date() ? .gray : .yellow)
                .frame(width: 5, height: 45)
            Image(journey.type.rawValue)
                .cornerRadius(40)
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading) {
                        Text(journey.title)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(journey.date, style: .time)
                            .font(.subheadline)
                    }
                }
                Text(journey.content)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
