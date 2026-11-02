import SwiftUI

enum AppSpacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
    static let row: CGFloat = 16
    static let headerImageWidth: CGFloat = 192
    static let headerImageHeight: CGFloat = 128
    static let pageHorizontal: CGFloat = 24
    static let pageTop: CGFloat = 24
    static let headerBottom: CGFloat = 16
    static let cardHeight: CGFloat = 88
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
    static let iconOlive = Color(red: 0.3804, green: 0.3804, blue: 0.3216)
    static let red = iconOlive
    static let orange = iconOlive
    static let yellow = iconOlive
    static let green = iconOlive
    static let blue = iconOlive
}
