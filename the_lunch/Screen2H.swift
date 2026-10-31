import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    static let screenBackground = Color(hex: 0xF3EDE6)
    static let cardBackground = Color(hex: 0xDCD1C4)
    static let titleColor = Color(hex: 0x4B5651)
    static let cardTitle = Color(hex: 0x1C1C1C)
    static let cardSubtitle = Color(hex: 0x6B6B66)

    // لوحة الألوان الموحدة حسب موضوع الأيقونة
    // نفس ألوان أيقونات صفحة الإسعافات الأولية
    static let topicEmergency = AppIconColor.red
    static let topicFire = AppIconColor.orange
    static let topicFirstAid = AppIconColor.green
    static let topicEnvironment = AppIconColor.green
    static let topicDisaster = AppIconColor.yellow
    static let topicWildlife = AppIconColor.blue
}

struct SafetyCategory: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String?
    let color: Color
}

private let categories = [
    SafetyCategory(title: "أرقام الطوارئ", subtitle: "الوصول السريع إلى أرقام الطوارئ والجهات المختصة", symbol: nil, color: .topicEmergency),
    SafetyCategory(title: "الحرائق", subtitle: "إرشادات للتعامل مع الحرائق", symbol: "flame", color: .topicFire),
    SafetyCategory(title: "الإسعافات الأولية", subtitle: "تعرّف على خطوات الإسعافات الأولية", symbol: "cross.case", color: .topicFirstAid),
    SafetyCategory(title: "السلامة البيئية", subtitle: "إرشادات السيول والعواصف لتجنب الكوارث", symbol: "leaf", color: .topicEnvironment),
    SafetyCategory(title: "الكوارث الطبيعية", subtitle: "تعرّف على المخاطر البيئية وطرق الوقاية", symbol: "cloud.sun.rain", color: .topicDisaster)
]

struct HomeScreen: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.screenBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("أسفرت وأنورت")
                            .font(.custom("Geeza Pro", size: AppFontSize.title))
                            .bold()
                            .foregroundStyle(Color.titleColor)
                            .padding(.top, 24)

                        Image("Group1")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 144)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.top, AppSpacing.xxl)

                        LazyVGrid(columns: columns, spacing: 24) {
                            ForEach(categories) { item in
                                categoryLink(for: item)
                            }
                        }
                        .padding(.top, 24)
                    }
                    .padding(.horizontal, AppSpacing.xxl)
                    .padding(.bottom, 32)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
    }

    @ViewBuilder
    private func categoryLink(for item: SafetyCategory) -> some View {
        switch item.title {
        case "أرقام الطوارئ":
            NavigationLink { EmergencyScreen() } label: { CategoryCard(item: item) }
                .buttonStyle(.plain)
        case "الحرائق":
            NavigationLink { GuidelinesScreen() } label: { CategoryCard(item: item) }
                .buttonStyle(.plain)
        case "الإسعافات الأولية":
            NavigationLink { FirstAidView() } label: { CategoryCard(item: item) }
                .buttonStyle(.plain)
        case "السلامة البيئية":
            NavigationLink { Screenr1() } label: { CategoryCard(item: item) }
                .buttonStyle(.plain)
        default:
            CategoryCard(item: item)
        }
    }
}

struct CategoryCard: View {
    let item: SafetyCategory

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.s) {
            Group {
                if let symbol = item.symbol {
                    Image(systemName: symbol).font(.system(size: 28))
                } else {
                    Text("SOS").font(.system(size: 36, weight: .heavy))
                }
            }
            .foregroundStyle(item.color)
            .frame(height: 34, alignment: .leading)

            Text(item.title)
                .font(.custom("Geeza Pro", size: AppFontSize.body))
                .bold()
                .foregroundStyle(Color.cardTitle)

            Text(item.subtitle)
                .font(.custom("Geeza Pro", size: AppFontSize.caption))
                .foregroundStyle(Color.cardSubtitle)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppSpacing.m)
        .padding(.vertical, AppSpacing.s)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 124)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.m))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

#Preview {
    HomeScreen()
}
