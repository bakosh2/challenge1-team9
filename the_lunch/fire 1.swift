import SwiftUI

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
    let steps: [String]
}

let guideCases = [
    GuideCase(title: "حريق الحطب والمخيم", imageName: "ha", photoName: "m", steps: [
        "ابتعد عن النار وأبعد الأطفال عنها فورًا.",
        "أطفئ النار بالماء أو بالرمل، ولا تتركها حتى تبرد تمامًا.",
        "إذا خرجت النار عن السيطرة اتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق السيارة", imageName: "car", photoName: "s", steps: [
        "أوقف السيارة في مكان آمن بعيدًا عن الأعشاب الجافة والمركبات الأخرى، إذا أمكن دون تعريض نفسك للخطر.",
        "أطفئ المحرك، وأخرج جميع الركاب فورًا، وساعد الأطفال وكبار السن إن أمكن بأمان.",
        "ابتعد عن السيارة مسافة آمنة، وابتعد عن حركة المرور والدخان واتجه إلى مكان آمن عكس اتجاه انتشار الدخان."
    ]),
    GuideCase(title: "حريق البطاريات والأجهزة الكهربائية", imageName: "b", photoName: "g", steps: [
        "افصل الجهاز عن الكهرباء إذا كان ذلك آمنًا.",
        "لا تستخدم الماء على الأجهزة الكهربائية، واستخدم طفاية مناسبة.",
        "ابتعد عن الدخان لأنه سام، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الغاز وموقد التخييم", imageName: "gaz 1", photoName: "p", steps: [
        "أغلق صمام الغاز إذا كان ذلك آمنًا.",
        "ابتعد فورًا عن الأسطوانة وأبعد الجميع عنها.",
        "لا تحاول إطفاء الحريق بنفسك، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الطبخ", imageName: "k", photoName: "d", steps: [
        "أطفئ مصدر الحرارة فورًا.",
        "غطِّ الإناء بغطاء محكم لخنق النار.",
        "لا تصب الماء على حريق الزيت أبدًا."
    ]),
    GuideCase(title: "الحروق والإصابات الناتجة عن النار", imageName: "a", photoName: "l", steps: [
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
        ZStack(alignment: .top) {
            // خلفية سادة مثل Screenr1
            Color.guideBeige.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    guideBanner

                    Spacer().frame(height: 5)

                    ForEach(guideCases) { item in
                        Button { selected = item } label: {
                            row(item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                .padding(.bottom, 40)
            }

            // سهم الرجوع: دايماً أعلى اليمين
            HStack {
                Spacer()
                backButton
            }
            .environment(\.layoutDirection, .leftToRight)
            .padding(.horizontal, 24)
            .padding(.top, 8)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarBackButtonHidden(true)
        .sheet(item: $selected) { item in
            GuideDetailView(item: item)
                .presentationDetents([.fraction(0.72), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                .presentationBackground(Color.guideBeige)
        }
    }

    // MARK: سهم الرجوع (نفس ستايل الزر الزجاجي في Screenr1)
    private var backButton: some View {
        Button { dismiss() } label: {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.guideOlive)
                .frame(width: 46, height: 46)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white.opacity(0.7), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.15), radius: 5, y: 3)
        }
        .buttonStyle(.plain)
    }

    // MARK: البانر (نفس HeaderCard: لون 616152 بشفافية 0.85، زوايا 20، ارتفاع 152)
    private var guideBanner: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("الارشادات")
                    .font(.custom("Geeza Pro", size: 30))
                    .bold()

                Text("تعلم كيف التصرف بامان باوقات الطوارئ")
                    .font(.custom("Geeza Pro", size: 20))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(.guideBeige)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.vertical, 20)

            Image("r")
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 152)
        .background(Color.guideOlive.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: الكارد (نفس SafetyCard: خط 18 bold، زوايا 25، ارتفاع 88، ظل خفيف)
    private func row(_ item: GuideCase) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.guideCircle.opacity(0.155))
                    .brightness(-0.15)
                    .frame(width: 56, height: 56)

                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }

            Text(item.title)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color.guideCard)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

// MARK: - الكارد اللي ينفتح (الصورة + الإرشادات)
struct GuideDetailView: View {
    let item: GuideCase

    var body: some View {
        ZStack {
            Color.guideBeige.ignoresSafeArea()
            content
        }
        .environment(\.layoutDirection, .rightToLeft)
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                // الصورة سكتش مثل r، و multiply يخفي الأبيض اللي حولها
                Image(item.photoName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 190)
                    .blendMode(.multiply)
                    .padding(.top, 10)

                Text(item.title)
                    .font(.custom("Geeza Pro", size: 30))
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                stepsList
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 40)
        }
    }

    // الإرشادات بدون خلفية
    private var stepsList: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("الإرشادات")
                .font(.custom("Geeza Pro", size: 20))
                .bold()
                .foregroundColor(.black)

            ForEach(item.steps.indices, id: \.self) { i in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "mountain.2.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.guideOlive)

                    Text(item.steps[i])
                        .font(.custom("Geeza Pro", size: 18))
                        .bold()
                        .foregroundColor(.black)
                        .lineSpacing(6)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    GuidelinesScreen()
}

