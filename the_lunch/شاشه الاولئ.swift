import SwiftUI

struct GuidelineItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct GuidelinesView: View {

    // أول عنصر يظهر يمين الصف (RTL)
    private let items: [GuidelineItem] = [
        .init(title: "حريق الحطب والمخيم", imageName: "ha"),
        .init(title: "حريق السيارة", imageName: "car"),
        .init(title: "حريق البطاريات والأجهزة الكهربائية", imageName: "b"),
        .init(title: "حريق الغاز وموقد التخييم", imageName: "gaz 1"),
        .init(title: "حريق الطبخ", imageName: "k"),
        .init(title: "الحروق والإصابات الناتجة عن النار", imageName: "a")
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var onSelect: (GuidelineItem) -> Void = { _ in }
    var onBack: () -> Void = {}
    var onFloatingTap: () -> Void = {}

    var body: some View {
        ZStack(alignment: .bottom) {
            background

            VStack(spacing: 0) {
                backButton
                    .padding(.horizontal, 22)
                    .padding(.top, 8)

                banner
                    .padding(.horizontal, 21)
                    .padding(.top, 24)

                sheet
                    .padding(.top, 36)
            }

            floatingButton
                .padding(.horizontal, 26)
                .padding(.bottom, 26)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: الخلفية
    private var background: some View {
        LinearGradient(
            colors: [Color(hex: 0xE9E1D6), Color(hex: 0xEFE8DF)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    // MARK: زر الرجوع (أعلى اليسار)
    private var backButton: some View {
        HStack {
            Spacer()
            Button(action: onBack) {
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 1))
                    .shadow(color: .black.opacity(0.12), radius: 8, y: 3)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.black.opacity(0.6))
                            .flipsForRightToLeftLayoutDirection(false)
                    )
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: البنر الأخضر (النص يمين، صورة الجبال "r" يسار)
    private var banner: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(hex: 0x5E6552))

            HStack(alignment: .center, spacing: 0) {
                // النص (يمين في RTL)
                VStack(alignment: .leading, spacing: 4) {
                    Text("الارشادات")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundStyle(.black)

                    Text("تعلم كيف التصرف بامان باوقات الطوارئ")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.black.opacity(0.7))
                        .lineSpacing(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // الصورة (يسار في RTL)
                Image("r")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 120)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 154)
    }

    // MARK: الجزء السفلي (الشبكة)
    private var sheet: some View {
        ZStack(alignment: .top) {
            UnevenRoundedRectangle(
                topLeadingRadius: 32,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 32,
                style: .continuous
            )
            .fill(Color(hex: 0xF3ECE4))
            .overlay(
                RadialGradient(
                    colors: [Color.white.opacity(0.55), .clear],
                    center: .init(x: 0.5, y: 0.12),
                    startRadius: 0,
                    endRadius: 220
                )
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 32,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 32,
                        style: .continuous
                    )
                )
            )

            LazyVGrid(columns: columns, spacing: 23) {
                ForEach(items) { item in
                    GuidelineTile(item: item) { onSelect(item) }
                }
            }
            .padding(.horizontal, 21)
            .padding(.top, 44)
        }
        .frame(maxHeight: .infinity)
    }

    // MARK: الزر العائم (أسفل اليمين)
    private var floatingButton: some View {
        HStack {
            Spacer()
            Button(action: onFloatingTap) {
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 1))
                    .shadow(color: .black.opacity(0.12), radius: 8, y: 3)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1.8)
                            .frame(width: 20, height: 20)
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - بطاقة الإرشاد
struct GuidelineTile: View {
    let item: GuidelineItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 38)

                Text(item.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 8)
            }
            .padding(.top, 12)
            .frame(maxWidth: .infinity, minHeight: 99, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(hex: 0xE4D8CC))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - مساعد الألوان
extension Color {
    init(hexValue: UInt32) {
        self.init(
            red:   Double((hexValue >> 16) & 0xFF) / 255,
            green: Double((hexValue >> 8)  & 0xFF) / 255,
            blue:  Double( hexValue        & 0xFF) / 255
        )
    }
}

#Preview {
    GuidelinesView()
}

