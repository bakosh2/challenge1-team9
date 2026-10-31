import SwiftUI
import UIKit

private extension Color {
    init(environmentHex value: String) {
        let rgb = Int(value, radix: 16) ?? 0
        self.init(
            red: Double((rgb >> 16) & 255) / 255,
            green: Double((rgb >> 8) & 255) / 255,
            blue: Double(rgb & 255) / 255
        )
    }
}

struct EnvironmentalGuide: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let iconColor: Color
    let image: String
    let steps: [String]
}

private let environmentalGuides = [
    EnvironmentalGuide(
        id: 1,
        title: "أشعل النار بمسؤولية",
        icon: "flame",
        iconColor: .topicFire,
        image: "FireCamp",
        steps: [
            "أطفئ النار تمامًا قبل المغادرة، وتأكد من عدم وجود جمر مشتعل.",
            "أبعدها عن النباتات والأعشاب والمواد القابلة للاشتعال.",
            "أشعل النار في الأماكن المسموح بها والمخصصة لذلك."
        ]
    ),
    EnvironmentalGuide(
        id: 2,
        title: "حافظ على نظافة المكان",
        icon: "trash.slash",
        iconColor: AppIconColor.green,
        image: "CleanCamp",
        steps: [
            "اجمع النفايات وضعها في أكياس، ثم تخلّص منها في الأماكن المخصصة.",
            "لا تترك البلاستيك أو بقايا الطعام في البر.",
            "احرص على تنظيف موقع التخييم قبل المغادرة."
        ]
    ),
    EnvironmentalGuide(
        id: 3,
        title: "اهتم بالنباتات البرية",
        icon: "leaf",
        iconColor: AppIconColor.green,
        image: "PlantsCamp",
        steps: [
            "لا تقطع الأشجار أو تقتلع النباتات البرية.",
            "تجنب دهس النباتات بالسيارة.",
            "لا تقطع الأغصان الحية ولا تستخدم الأشجار الحية حطبًا لإشعال النار."
        ]
    ),
    EnvironmentalGuide(
        id: 4,
        title: "الحفاظ على الحياة الفطرية",
        icon: "pawprint",
        iconColor: AppIconColor.blue,
        image: "WildlifeCamp",
        steps: [
            "راقب الحيوانات من مسافة آمنة.",
            "لا تطعم الحيوانات البرية؛ فقد يضر ذلك بصحتها وسلوكها الطبيعي.",
            "تجنب إزعاج الكائنات الحية."
        ]
    )
]

struct Screenr1: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGuide: EnvironmentalGuide?

    var body: some View {
        ZStack {
            Color.guideBeige.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    EnvironmentalHeaderCard()
                        .padding(.top, 24)

                    ForEach(environmentalGuides) { guide in
                        Button { selectedGuide = guide } label: {
                            EnvironmentalCard(guide: guide)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .tint(Color.guideOlive)
        .sheet(item: $selectedGuide) { guide in
            EnvironmentalGuideSheet(guide: guide)
                .presentationDetents([.fraction(0.72), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
                .presentationBackground(Color.guideBeige)
        }
    }
}

private struct EnvironmentalHeaderCard: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.guideOlive.opacity(0.85))

            Image("c1")
                .resizable()
                .scaledToFit()
                .frame(width: 192)
                .opacity(0.75)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            VStack(alignment: .leading, spacing: 8) {
                Text("السلامة البيئية")
                    .font(.custom("Geeza Pro", size: AppFontSize.title))
                    .bold()

                Text("تخيّم بوعي، واترك الطبيعة أجمل.")
                    .font(.custom("Geeza Pro", size: AppFontSize.body))
            }
            .foregroundStyle(Color.guideBeige)
            .padding(20)
        }
        .frame(height: 152)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

private struct EnvironmentalCard: View {
    let guide: EnvironmentalGuide

    var body: some View {
        HStack(spacing: AppSpacing.m) {
            Image(systemName: guide.icon)
                .font(.system(size: 24))
                .foregroundStyle(guide.iconColor)
                .frame(width: 56, height: 56)
                .background(Color.aidCardDark, in: Circle())

            Text(guide.title)
                .font(.custom("Geeza Pro", size: AppFontSize.body))
                .bold()
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color.guideCard)
        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.xxl))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

private struct EnvironmentalGuideSheet: View {
    let guide: EnvironmentalGuide

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                EnvironmentalImage(name: guide.image, fallback: guide.icon)
                    .frame(width: 192, height: 160)
                    .padding(.top, 8)

                Text(guide.title)
                    .font(.custom("Geeza Pro", size: AppFontSize.title))
                    .bold()
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                environmentalStepsCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color.guideBeige.ignoresSafeArea())
        .environment(\.layoutDirection, .rightToLeft)
    }

    private var environmentalStepsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("الإرشادات")
                .font(.custom("Geeza Pro", size: AppFontSize.body))
                .bold()
                .foregroundStyle(.black)
                .padding(.bottom, 8)

            ForEach(guide.steps, id: \.self) { step in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mountain.2.circle")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.guideOlive)

                    Text(step)
                        .font(.custom("Geeza Pro", size: AppFontSize.body))
                        .foregroundStyle(.black)
                        .lineSpacing(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.guideCard, in: RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
    }
}

private struct EnvironmentalImage: View {
    let name: String
    let fallback: String

    var body: some View {
        Group {
            if UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: fallback)
                    .font(.system(size: 58, weight: .semibold))
                    .foregroundStyle(Color.guideOlive)
            }
        }
    }
}

#Preview {
    NavigationStack { Screenr1() }
}
