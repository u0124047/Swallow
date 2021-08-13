//
//  Baby.swift
//  Swallow
//
//  Created by Kathy on 2021/8/11.
//

import SwiftUI

struct Baby: Identifiable {
    var id = UUID()
    var name: String = ""
    var gender: Int = 0
    var birth: Date = Date()
    var mom: String = ""
    var dad: String = ""
    
    init() {
    }
    
    init(name: String, gender: Int, birth: Date, mom: String, dad: String) {
        self.name = name
        self.gender = gender
        self.birth = birth
        self.mom = mom
        self.dad = dad
    }
}
