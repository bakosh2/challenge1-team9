import SwiftUI

// MARK: - الألوان (نفس ألوان الكود الأول)
extension Color {
    init(hex: UInt32) {
        self.init(
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8)  & 0xFF) / 255,
            blue:  Double( hex        & 0xFF) / 255
        )
    }

    static let screenBackground = Color(hex: 0xF3EDE6) // خلفية الشاشة
    static let cardBackground   = Color(hex: 0xDCD1C4) // البطاقات
    static let titleColor       = Color(hex: 0x4B5651) // عنوان الشاشة
    static let cardTitle        = Color(hex: 0x1C1C1C) // عنوان البطاقة
    static let cardSubtitle     = Color(hex: 0x6B6B66) // الوصف الصغير
}

// MARK: - بيانات البطاقات
struct SafetyCategory: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String?   // nil = تعرض نص SOS بدل الأيقونة
    let color: Color
}

// أول عنصر يطلع يمين لأن الاتجاه RTL
private let categories = [
    SafetyCategory(title: "أرقام الطوارئ",
                   subtitle: "الوصول السريع إلى أرقام الطوارئ والجهات المختصة",
                   symbol: nil, color: Color(hex: 0x8E1B1B)),
    SafetyCategory(title: "الحرائق",
                   subtitle: "إرشادات للتعامل مع الحرائق",
                   symbol: "flame", color: Color(hex: 0xC8703A)),
    SafetyCategory(title: "الإسعافات الأولية",
                   subtitle: "تعرّف على خطوات الإسعافات الأولية",
                   symbol: "cross.case", color: Color(hex: 0xD03A2C)),
    SafetyCategory(title: "السلامة البيئية",
                   subtitle:"ارشادات السيول و العواصف لتجنب الكوارث ",
                   symbol: "leaf", color: Color(hex: 0x2F4A1E)),
    SafetyCategory(title: "الكوارث الطبيعية",
                   subtitle: "تعرّف على المخاطر البيئية وطرق الوقاية",
                   symbol: "cloud.sun.rain", color: Color(hex: 0x5B7FC4))
]

// MARK: - الشاشة الرئيسية
struct HomeScreen: View {

    // عمودين بينهم 45pt
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 45), count: 2)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.screenBackground.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {

                    Text("أسفرت و أنورت")
                        .font(.system(size: 30))
                        .foregroundColor(.titleColor)
                        .padding(.top, 24)

                    // صورة الكارد: أضفها في Assets.xcassets باسم "card"
                    Image("Group1")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 152)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 22)

                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(categories) { item in
                            if item.title == "أرقام الطوارئ" {
                                // كارد الطوارئ يفتح شاشة الأرقام
                                NavigationLink {
                                    EmergencyScreen()
                                } label: {
                                    CategoryCard(item: item)
                                }
                                .buttonStyle(.plain)
                            } else {
                                CategoryCard(item: item)
                            }
                        }
                    }
                    .padding(.top, 79)

                    Spacer()
                }
                .padding(.horizontal, 21)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
    }
}

// MARK: - بطاقة واحدة
struct CategoryCard: View {
    let item: SafetyCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            // الأيقونة: SF Symbol أو نص SOS
            Group {
                if let symbol = item.symbol {
                    Image(systemName: symbol).font(.system(size: 30))
                } else {
                    Text("SOS").font(.system(size: 36, weight: .heavy).width(.condensed))
                }
            }
            .foregroundColor(item.color)
            .frame(height: 34, alignment: .leading)

            Text(item.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.cardTitle)

            Text(item.subtitle)
                .font(.system(size: 10.5))
                .foregroundColor(.cardSubtitle)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 115)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

#Preview {
    HomeScreen()
}
