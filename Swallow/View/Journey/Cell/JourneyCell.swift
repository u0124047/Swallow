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
            if let date = journey.date {
                RoundedRectangle(cornerRadius: 2.5)
                    .foregroundColor(date<Date() ? .gray : .yellow)
                    .frame(width: 5, height: 45)
            }

            if let imgName = journey.journeyType {
                Image(imgName)
                    .cornerRadius(40)
            }

            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading) {
                        if let title = journey.title {
                            Text(title)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        if let date = journey.date {
                            Text(date, style: .time)
                                .font(.subheadline)
                        }
                    }
                }
                if let content = journey.content {
                    Text(content)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
