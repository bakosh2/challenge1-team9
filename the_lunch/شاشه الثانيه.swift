import SwiftUI

// MARK: - الألوان (أسماء مختلفة عشان ما تتكرر مع الملفات الثانية)
extension Color {
    init(guideHex: UInt32) {
        self.init(
            red: Double((guideHex >> 16) & 0xFF) / 255,
            green: Double((guideHex >> 8) & 0xFF) / 255,
            blue: Double(guideHex & 0xFF) / 255
        )
    }

    static let guideOlive = Color(guideHex: 0x5E6552)
    static let guideBeige = Color(guideHex: 0xEDE6DB)
    static let guideSand = Color(guideHex: 0xE3D8CE)
    static let guideGreen = Color(guideHex: 0x3F6B4A)
}

// MARK: - الموديل
struct GuideCase: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let steps: [String]
}

let guideCases = [
    GuideCase(title: "حريق الحطب والمخيم", imageName: "ha", steps: [
        "ابتعد عن النار وأبعد الأطفال عنها فورًا.",
        "أطفئ النار بالماء أو بالرمل، ولا تتركها حتى تبرد تمامًا.",
        "إذا خرجت النار عن السيطرة اتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق السيارة", imageName: "car", steps: [
        "أوقف السيارة في مكان آمن بعيدًا عن الأعشاب الجافة والمركبات الأخرى، إذا أمكن دون تعريض نفسك للخطر.",
        "أطفئ المحرك، وأخرج جميع الركاب فورًا، وساعد الأطفال وكبار السن إن أمكن بأمان.",
        "ابتعد عن السيارة مسافة آمنة، وابتعد عن حركة المرور والدخان واتجه إلى مكان آمن عكس اتجاه انتشار الدخان."
    ]),
    GuideCase(title: "حريق البطاريات والأجهزة الكهربائية", imageName: "b", steps: [
        "افصل الجهاز عن الكهرباء إذا كان ذلك آمنًا.",
        "لا تستخدم الماء على الأجهزة الكهربائية، واستخدم طفاية مناسبة.",
        "ابتعد عن الدخان لأنه سام، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الغاز وموقد التخييم", imageName: "gaz 1", steps: [
        "أغلق صمام الغاز إذا كان ذلك آمنًا.",
        "ابتعد فورًا عن الأسطوانة وأبعد الجميع عنها.",
        "لا تحاول إطفاء الحريق بنفسك، واتصل بالدفاع المدني 998."
    ]),
    GuideCase(title: "حريق الطبخ", imageName: "k", steps: [
        "أطفئ مصدر الحرارة فورًا.",
        "غطِّ الإناء بغطاء محكم لخنق النار.",
        "لا تصب الماء على حريق الزيت أبدًا."
    ]),
    GuideCase(title: "الحروق والإصابات الناتجة عن النار", imageName: "a", steps: [
        "أبعد المصاب عن مصدر النار.",
        "برّد الحرق بماء جارٍ لمدة 20 دقيقة.",
        "غطّه بشاش نظيف ولا تفقع الفقاعات، وإذا كان الحرق شديدًا اتصل بالإسعاف 997."
    ])
]

// MARK: - ستايل القلاس
extension View {
    func glassCard(radius: CGFloat = 20) -> some View {
        self
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
    }
}

// MARK: - الصفحة الرئيسية
struct GuidelinesScreen: View {
    @State private var selected: GuideCase?

    var onBack: () -> Void = {}

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        ZStack {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {

                    // زر الرجوع (يمين فوق)
                    HStack {
                        Button(action: onBack) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.black.opacity(0.6))
                                .frame(width: 50, height: 50)
                                .background(.ultraThinMaterial, in: Circle())
                                .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 1))
                                .shadow(color: .black.opacity(0.12), radius: 8, y: 3)
                        }
                        .buttonStyle(.plain)

                        Spacer()
                    }

                    // المربع الأخضر + صورة r
                    guideBanner()

                    // الكاردات (قلاس)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(guideCases) { item in
                            Button { selected = item } label: {
                                card(item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 21)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        // الكارد اللي يطلع لما تضغط: يفتح نص الشاشة فقط
        .sheet(item: $selected) { item in
            GuideDetailView(item: item)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(.ultraThinMaterial)
        }
    }

    // الخلفية
    var background: some View {
        ZStack {
            LinearGradient(colors: [.guideBeige, .guideSand], startPoint: .top, endPoint: .bottom)
            Circle().fill(Color.guideOlive.opacity(0.35))
                .frame(width: 250).blur(radius: 60).offset(x: 130, y: -250)
            Circle().fill(Color.brown.opacity(0.25))
                .frame(width: 280).blur(radius: 70).offset(x: -140, y: 200)
        }
        .ignoresSafeArea()
    }

    // الكارد القلاس
    func card(_ item: GuideCase) -> some View {
        VStack(spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 38)

            Text(item.title)
                .font(.custom("Geeza Pro", size: 15))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
        }
        .padding(.top, 12)
        .frame(maxWidth: .infinity, minHeight: 99, alignment: .top)
        .glassCard(radius: 18)
    }
}

// MARK: - المربع الأخضر (صورة r) للصفحة الرئيسية
func guideBanner() -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Color.guideOlive)

        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("الارشادات")
                    .font(.custom("Geeza Pro", size: 32))
                    .foregroundColor(.black)

                Text("تعلم كيف التصرف بامان باوقات الطوارئ")
                    .font(.custom("Geeza Pro", size: 12))
                    .foregroundColor(Color.black.opacity(0.7))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image("r")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .frame(maxWidth: 140)
        }
        .padding(.horizontal, 20)
    }
    .frame(height: 155)
}

// MARK: - صفحة التفاصيل (تطلع نص شاشة، وفيها كارد قلاس داخلها)
struct GuideDetailView: View {
    let item: GuideCase

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 14) {

                // صورة r لحالها في النص
                Image("r")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)

                // العنوان
                Text(item.title)
                    .font(.custom("Geeza Pro", size: 20))
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                // الكارد القلاس اللي داخل الشيت (الإرشادات)
                VStack(alignment: .leading, spacing: 18) {
                    Text("الإرشادات")
                        .font(.custom("Geeza Pro", size: 16))
                        .bold()
                        .foregroundColor(.black)

                    ForEach(item.steps.indices, id: \.self) { i in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 22))
                                .foregroundColor(.guideGreen)

                            Text(item.steps[i])
                                .font(.custom("Geeza Pro", size: 20))
                                .bold()
                                .foregroundColor(.black)
                                .lineSpacing(6)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassCard(radius: 24)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    GuidelinesScreen()
}
