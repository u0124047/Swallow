//
//  Journey.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI

enum JourneyType: String, CaseIterable {
    case doctor = "doctor"
    case grandma = "grandma"
    case shopping = "shopping"
    case restaurant = "restaurant"
    
    func localize() -> String {
        switch self {
        case .doctor:
            return "看診"
        case .grandma:
            return "外婆家"
        case .shopping:
            return "購物"
        case .restaurant:
            return "吃飯"
        }
    }
}

struct Journey: Identifiable {
    var id = UUID()
    var title: String = ""
    var type: JourneyType = .doctor
    var content: String = ""
    var date: Date = Date()
    var images: [Image] = []
    
    var imageName: String { return type.rawValue }
    
    init() {
    }
    
    init(title: String, type: JourneyType, content: String, date: Date, images: [Image]) {
        self.title = title
        self.type = type
        self.content = content
        self.date = date
        self.images = images
    }
}

#if DEBUG
let testData = [
    Journey(title: "看醫生", type: .doctor, content: "2樓9號林醫生\n打了兩支針，哀哀叫，不過五分鐘後就睡著了。", date: "2021/06/23".convertToDate(), images: [Image("img1")]),
    Journey(title: "看醫生", type: .doctor, content: "1樓12號陳醫生", date: "2021/06/23".convertToDate(), images: [Image("img2"), Image("img3"), Image("img4")]),
    Journey(title: "外婆家", type: .grandma, content: "看外婆", date: "2021/07/30".convertToDate(), images: [Image("img5")]),
    Journey(title: "購物", type: .shopping, content: "家樂福", date: "2021/08/12".convertToDate(), images: [Image("img6"), Image("img7")]),
]
#endif

