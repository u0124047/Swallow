//
//  JourneyDetail.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI

struct JourneyDetail: View {
    var journey: Journey
    var body: some View {
        VStack {
            Image(journey.type.rawValue)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.orange, lineWidth: 4)
                )
                .shadow(radius: 10)
            Text(journey.date, style: .time)
                .font(.subheadline)
            Divider()
            let images = journey.images
            ForEach(0..<images.count) { idx in
                ZStack(alignment: .bottomTrailing) {
                    images[idx]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            Text(journey.content)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(50)

            Spacer()
        }.padding().navigationBarTitle(Text(journey.title), displayMode: .inline)
    }
}
