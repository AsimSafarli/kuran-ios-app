//
//  Extension.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//

import Foundation
import SwiftUI

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isNotEmpty: Bool {
        return !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}


extension Color {
    init(_ colorName: String) {
        switch colorName {
        case "blue":
            self = .blue
        case "green":
            self = .green
        case "pink":
            self = .pink
        case "purple":
            self = .purple
        case "orange":
            self = .orange
        case "teal":
            self = .teal
        default:
            self = .blue
        }
    }
}

//
//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
//}


extension Date {
    func asString(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
}

