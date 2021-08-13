//
//  Utils.swift
//  Swallow
//
//  Created by Kathy on 2021/8/11.
//

import SwiftUI

extension Date {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: self)
    }

    func isSameDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs:date)
    }

    func daysBetweenNow() -> (year: Int, month: Int, day: Int, text: String) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        let year = components.year ?? 0
        let month = components.month ?? 0
        let day = components.day ?? 0
        return (year: year, month: month, day: day, text: "\(year)歲\(month)月\(day)天")
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

extension View {

    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from:self) ?? Date()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension Color {
    static let darkPurpleColor = Color(hex: "692FC0")
    static let purpleColor = Color(hex: "692FC0")
    static let pinkColor = Color(hex: "F27280")
    static let greenColor = Color(hex: "3CBD6E")
    static let orangeColor = Color(hex: "FEBD16")
    static let blueColor = Color(hex: "4BAED7")
    static let yellowColor = Color(hex: "FEBD16")
    static let bgColor = LinearGradient(gradient: Gradient(colors: [Color(hex: "F27280"), Color(hex: "692FC0")]), startPoint: .top, endPoint: .bottom)
}
