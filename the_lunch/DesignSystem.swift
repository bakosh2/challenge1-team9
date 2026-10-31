import SwiftUI

enum AppSpacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
}

enum AppFontSize {
    static let caption: CGFloat = 12
    static let body: CGFloat = 16
    static let section: CGFloat = 20
    static let title: CGFloat = 24
    static let largeTitle: CGFloat = 28
}

// لوحة ألوان السلامة المشتركة بين جميع الصفحات
// الدلالات مبنية على ترميز السلامة الشائع: خطر، حريق/تحذير، تنبيه، أمان، ومعلومة.
enum AppIconColor {
    static let red = Color(hex: 0x9B2423)
    static let orange = Color(hex: 0xF9A800)
    static let yellow = Color(hex: 0xB87900)
    static let green = Color(hex: 0x237F52)
    static let blue = Color(hex: 0x1976D2)
}
