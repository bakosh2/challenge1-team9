
import SwiftUI

// MARK: - الألوان
extension Color {
    init(hex: String) {
        let rgb = Int(hex, radix: 16) ?? 0
        self.init(
            red: Double((rgb >> 16) & 255) / 255,
            green: Double((rgb >> 8) & 255) / 255,
            blue: Double(rgb & 255) / 255
        )
    }
}

// MARK: - بيانات الإرشادات
struct EnvironmentalGuide: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let iconColor: Color
    let image: String
    let steps: [String]
}

let environmentalGuides: [EnvironmentalGuide] = [

    EnvironmentalGuide(
        id: 1,
        title: "أشعل النار بمسؤولية",
        icon: "flame",
        iconColor: Color(hex: "BB3939"),
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
        iconColor: Color(hex: "4A4A4A"),
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
        iconColor: Color(hex: "2B6C07"),
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
        iconColor: Color(hex: "C86306"),
        image: "WildlifeCamp",
        steps: [
            "راقب الحيوانات من مسافة آمنة.",
            "لا تطعم الحيوانات البرية؛ فقد يضر ذلك بصحتها وسلوكها الطبيعي.",
            "تجنب إزعاج الكائنات الحية."
        ]
    )
]

// MARK: - الشاشة الأولى
struct Screenr1: View {

    @Environment(\.dismiss) private var dismiss
    @State private var selectedGuide: EnvironmentalGuide?

    var body: some View {

        ZStack {

            Color(hex: "F3EDE6")
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {

                // زر الرجوع الزجاجي أعلى الشاشة
                HStack {

                    Button {
                        dismiss()
                    } label: {

                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "616152"))
                            .frame(width: 58, height: 58)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(
                                        .white.opacity(0.7),
                                        lineWidth: 1
                                    )
                            }
                            .shadow(
                                color: .black.opacity(0.15),
                                radius: 5,
                                y: 3
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .padding(.top, 15)

                // الكارد الزيتي
                HeaderCard()
                    .padding(.top, 55)

                Spacer().frame(height: 25)

                // الكاردات الأربعة
                ForEach(environmentalGuides) { guide in

                    Button {
                        selectedGuide = guide
                    } label: {

                        SafetyCard(
                            title: guide.title,
                            icon: guide.icon,
                            iconColor: guide.iconColor
                        )
                    }
                    .buttonStyle(.plain)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .toolbar(.hidden, for: .navigationBar)

        // فتح الكارد البيج فوق نفس الشاشة
        .sheet(item: $selectedGuide) { guide in

            EnvironmentalGuideSheet(guide: guide)
                .presentationDetents([.fraction(0.72), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                .presentationBackground(Color(hex: "F3EDE6"))
        }
    }
}

// MARK: - الكارد الزيتي
struct HeaderCard: View {

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 20)
                .overlay {

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "616152").opacity(0.85))
                }

            // صورة الجبل
            Image("c1")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .opacity(0.65)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )

            VStack(alignment: .leading, spacing: 8) {

                Text("السلامة البيئية")
                    .font(.custom("Geeza Pro", size: 30))
                    .bold()

                Text("تخيّم بوعي، واترك الطبيعة أجمل.")
                    .font(.custom("Geeza Pro", size: 20))
                    .multilineTextAlignment(.trailing)
            }
            .foregroundColor(Color(hex: "F3EDE6"))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(20)
        }
        .frame(width: 356, height: 152)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - الكاردات الأربعة
struct SafetyCard: View {

    let title: String
    let icon: String
    let iconColor: Color

    var body: some View {

        HStack(spacing: 14) {

            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(iconColor)
                .frame(width: 56, height: 56)
                .background(
                    Color(hex: "6B746F").opacity(0.155)
                )
                .clipShape(Circle())
                .brightness(-0.15)

            Text(title)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color(hex: "DCD1C4"))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
        .shadow(
            color: .black.opacity(0.08),
            radius: 4,
            y: 2
        )
    }
}

// MARK: - الكارد البيج للإرشادات
struct EnvironmentalGuideSheet: View {

    let guide: EnvironmentalGuide

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(spacing: 18) {

                // صورة الإرشاد
                Image(guide.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 190)
                    .padding(.top, 10)

                // الإرشادات الثلاثة
                VStack(alignment: .leading, spacing: 60) {

                    ForEach(guide.steps, id: \.self) { step in

                        HStack(alignment: .top, spacing: 12) {

                            Image(systemName: "mountain.2.circle")
                                .font(.system(size: 25))
                                .foregroundColor(Color(hex: "616152"))

                            Text(step)
                                .font(.custom("Geeza Pro", size: 18))
                                .bold()
                                .foregroundColor(.black)
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )

                            Spacer(minLength: 0)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    }
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 40)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        Screenr1()
    }
}

