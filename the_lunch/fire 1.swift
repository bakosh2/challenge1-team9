import SwiftUI
import UIKit

// MARK: - الألوان (نفس ألوان Screenr1)
// ملاحظة: سميت الـ init باسم guideHex عشان ما يتعارض مع init(hex:) اللي في كود زميلتك
extension Color {
    init(guideHex: UInt32) {
        self.init(
            red: Double((guideHex >> 16) & 0xFF) / 255,
            green: Double((guideHex >> 8) & 0xFF) / 255,
            blue: Double(guideHex & 0xFF) / 255
        )
    }

    static let guideBeige  = Color(guideHex: 0xF3EDE6)   // الخلفية + لون نص البانر
    static let guideOlive  = Color(guideHex: 0x616152)   // البانر والأيقونات
    static let guideCard   = Color(guideHex: 0xDCD1C4)   // الكاردات
    static let guideCircle = Color(guideHex: 0x6B746F)   // دائرة الأيقونة
}

// MARK: - الموديل
// imageName = الأيقونة الصغيرة في القائمة
// photoName = الصورة الكرتونية الكبيرة اللي تطلع داخل الكارد
struct GuideCase: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let photoName: String
    let color: Color
    let steps: [String]
}

let guideCases = [
    GuideCase(title: "حريق الحطب والمخيم", imageName: "ha", photoName: "fire_forest", color: AppIconColor.orange, steps: [
        "ابتعد عن النار وأبعد الأطفال عنها فورًا.",
        "أطفئ النار بالماء أو بالرمل، ولا تتركها حتى تبرد تمامًا.",
        "إذا خرجت النار عن السيطرة اتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق السيارة", imageName: "car", photoName: "fire_liquid", color: AppIconColor.red, steps: [
        "أوقف السيارة في مكان آمن بعيدًا عن الأعشاب الجافة والمركبات الأخرى، إذا أمكن دون تعريض نفسك للخطر.",
        "أطفئ المحرك، وأخرج جميع الركاب فورًا، وساعد الأطفال وكبار السن إن أمكن بأمان.",
        "ابتعد عن السيارة مسافة آمنة، وابتعد عن حركة المرور والدخان واتجه إلى مكان آمن عكس اتجاه انتشار الدخان."
    ]),
    GuideCase(title: "حريق البطاريات والأجهزة الكهربائية", imageName: "b", photoName: "fire_electrical", color: AppIconColor.yellow, steps: [
        "افصل الجهاز عن الكهرباء إذا كان ذلك آمنًا.",
        "لا تستخدم الماء على الأجهزة الكهربائية، واستخدم طفاية مناسبة.",
        "ابتعد عن الدخان لأنه سام، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الغاز وموقد التخييم", imageName: "gaz 1", photoName: "fire_gas", color: AppIconColor.orange, steps: [
        "أغلق صمام الغاز إذا كان ذلك آمنًا.",
        "ابتعد فورًا عن الأسطوانة وأبعد الجميع عنها.",
        "لا تحاول إطفاء الحريق بنفسك، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الطبخ", imageName: "k", photoName: "fire_stove", color: AppIconColor.orange, steps: [
        "أطفئ مصدر الحرارة فورًا.",
        "غطِّ الإناء بغطاء محكم لخنق النار.",
        "لا تصب الماء على حريق الزيت أبدًا."
    ]),
    GuideCase(title: "الحروق والإصابات الناتجة عن النار", imageName: "a", photoName: "fire_oil", color: AppIconColor.red, steps: [
        "أبعد المصاب عن مصدر النار.",
        "برّد الحرق بماء جارٍ لمدة 20 دقيقة.",
        "غطّه بشاش نظيف ولا تفقع الفقاعات، وإذا كان الحرق شديدًا اتصل بالإسعاف 997."
    ])
]

// MARK: - الصفحة الرئيسية
struct GuidelinesScreen: View {
    @State private var selected: GuideCase?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // خلفية سادة مثل Screenr1
            Color.guideBeige.ignoresSafeArea()

            VStack(spacing: 0) {
                guideBanner
                    .padding(.horizontal, AppSpacing.pageHorizontal)
                    .padding(.top, AppSpacing.pageTop)
                    .padding(.bottom, AppSpacing.headerBottom)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: AppSpacing.row) {
                    ForEach(guideCases) { item in
                        Button { selected = item } label: {
                            row(item)
                        }
                        .buttonStyle(.plain)
                    }
                    }
                    .padding(.horizontal, AppSpacing.pageHorizontal)
                    .padding(.bottom, 32)
                }
            }

        }
        .environment(\.layoutDirection, .rightToLeft)
        .tint(Color.guideOlive)
        .sheet(item: $selected) { item in
            GuideDetailView(item: item)
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                .presentationBackground(Color.guideBeige)
        }
    }

    // MARK: البانر (نفس HeaderCard: لون 616152 بشفافية 0.85، زوايا 20، ارتفاع 152)
    private var guideBanner: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.guideOlive.opacity(0.85))

            Image("r")
                .resizable()
                .scaledToFit()
                .frame(width: AppSpacing.headerImageWidth, height: AppSpacing.headerImageHeight)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

            VStack(alignment: .leading, spacing: 8) {
                Text("الحرائق")
                    .font(.custom("Geeza Pro", size: AppFontSize.title))
                    .bold()

                Text("تعلّم كيف تتصرف بأمان في\nأوقات الطوارئ")
                    .font(.custom("Geeza Pro", size: AppFontSize.body))
                    .multilineTextAlignment(.leading)
            }
            .foregroundStyle(Color.guideBeige)
            .padding(20)
        }
        .frame(height: 152)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: الكارد (نفس SafetyCard: خط 18 bold، زوايا 25، ارتفاع 88، ظل خفيف)
    private func row(_ item: GuideCase) -> some View {
        HStack(spacing: AppSpacing.m) {
            ZStack {
                Circle()
                    .fill(Color.aidCardDark)
                    .frame(width: 56, height: 56)

                Image(item.imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(AppIconColor.iconOlive)
                    .tint(AppIconColor.iconOlive)
            }

            Text(item.title)
                .aidFont(AppFontSize.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .frame(height: AppSpacing.cardHeight)
        .background(Color.guideCard)
        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.xxl))
        .overlay(
            RoundedRectangle(cornerRadius: AppSpacing.xxl)
                .stroke(.white.opacity(0.6), lineWidth: 1)
        )
        .contentShape(RoundedRectangle(cornerRadius: AppSpacing.xxl))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

// MARK: - الكارد اللي ينفتح (الصورة + الإرشادات)
struct GuideDetailView: View {
    let item: GuideCase

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                // الصورة سكتش مثل r، و multiply يخفي الأبيض اللي حولها
                GuideImage(name: item.photoName, fallback: item.imageName)
                    .frame(width: 192, height: 160)
                    .padding(.top, 8)

                Text(item.title)
                    .font(.custom("Geeza Pro", size: AppFontSize.title))
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                stepsCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color.guideBeige.ignoresSafeArea())
        .environment(\.layoutDirection, .rightToLeft)
    }

    private var stepsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("الإرشادات")
                .font(.custom("Geeza Pro", size: AppFontSize.body))
                .bold()
                .foregroundColor(.black)
                .padding(.bottom, 8)

            ForEach(item.steps.indices, id: \.self) { i in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mountain.2.circle")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.guideOlive)

                    Text(item.steps[i])
                        .font(.custom("Geeza Pro", size: AppFontSize.body))
                        .foregroundColor(.black)
                        .lineSpacing(6)
                        .multilineTextAlignment(.leading)
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

private struct GuideImage: View {
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
    GuidelinesScreen()
}

