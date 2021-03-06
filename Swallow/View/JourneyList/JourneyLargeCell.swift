//
//  JourneyLargeCell.swift
//  Swallow
//
//  Created by Kathy on 2021/8/12.
//

import SwiftUI

struct JourneyLargeCell: View {
    let journey: Journey
    @State private var pageIndex: Int = 0

    var body: some View {
        NavigationLink(destination: JourneyDetail(journey: journey)) {
            VStack {
                HStack {
                    Image("mom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .padding(.leading)
                    Text("Mommy")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        // TODO: 分享至IG限時動態
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.original)
                            .padding(.trailing)
                    }
                }
                .background(Color.clear)
                ScrollView {
                    LazyVStack {
                        ZStack(alignment: .topTrailing) {
                            ZStack(alignment: .bottomTrailing) {
                                pageImageView()
                                if let date = journey.date {
                                    Text(date.daysBetweenNow().text)
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding()
                                }
                            }
                            if let journeyId = journey.id {
                                let images = Photo.getAllPhotos(journeyId: journeyId)
                                if images.count > 1 {
                                    ZStack(alignment: .topTrailing) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black.opacity(0.4))
                                            .frame(width: 30, height: 20)
                                        Text("\(self.pageIndex+1)/\(images.count)")
                                            .frame(width: 30, height: 20, alignment: .center)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.white)
                                    }
                                    .padding(8)
                                }
                            }
                        }
                        if let title = journey.title {
                            Text(title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                        if let content = journey.content {
                            Text(content)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 14))
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }

    func pageImageView() -> some View {
        TabView {
            if let journeyId = journey.id {
                let images = Photo.getAllPhotos(journeyId: journeyId)
                ForEach(0..<images.count) { idx in
                    if let data = images[idx].data, let image = UIImage(data: data) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}


