//
//  JourneyTypeCell.swift
//  Swallow
//
//  Created by Kathy on 2021/8/10.
//

import SwiftUI

struct JourneyTypeCell: View {
    let journeyType: JourneyType
    var body: some View {
        if let imgName = journeyType.key {
            Image(imgName).cornerRadius(40)
        }
    }
}
