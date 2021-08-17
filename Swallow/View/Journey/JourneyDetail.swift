//
//  JourneyDetail.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI
import UIKit

struct JourneyDetail: View {
    var journey: Journey
    var body: some View {
        if let title = journey.title {
            VStack {
                if let imgName = journey.journeyType {
                    Image(imgName)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.orange, lineWidth: 4)
                        )
                        .shadow(radius: 10)
                }
                if let date = journey.date {
                    Text(date, style: .time)
                        .font(.subheadline)
                }
                Divider()
                if let journeyId = journey.id {
                    let images = Photo.getAllPhotos(journeyId: journeyId)
                    ForEach(0..<images.count) { idx in
                        if let data = images[idx].data, let image = UIImage(data: data) {
                            ZStack(alignment: .bottomTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            }
                        }
                    }
                }
                if let content = journey.content {
                    Text(content)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(50)
                }

                Spacer()
            }.padding().navigationBarTitle(Text(title), displayMode: .inline)
        }
    }
}
