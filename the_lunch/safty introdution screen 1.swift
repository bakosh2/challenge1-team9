import SwiftUI

// MARK: - الألوان
extension Color {
    init(aidHex: UInt32) {
        self.init(
            red: Double((aidHex >> 16) & 0xFF) / 255,
            green: Double((aidHex >> 8) & 0xFF) / 255,
            blue: Double(aidHex & 0xFF) / 255
        )
    }

    static let aidBackground = Color(aidHex: 0xF3EDE6)
    static let aidOlive = Color(aidHex: 0x6B746F)
    static let aidCard = Color(aidHex: 0xDCD1C4)
    static let aidCardDark = Color(aidHex: 0xCFC2B3)

    // ألوان السلامة (ISO 3864)
    static let aidRed = Color(aidHex: 0x9B2423)
    static let aidYellow = Color(aidHex: 0xF9A800)
    static let aidGreen = Color(aidHex: 0x237F52)
}

// MARK: - التباعد (مضاعفات 4)
private enum Space {
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
}

// MARK: - ستايل مشترك
extension View {
    func aidFont(_ size: CGFloat) -> some View {
        font(.custom("Geeza Pro", size: size)).fontWeight(.bold)
    }

    func aidGlass(radius: CGFloat = 24) -> some View {
        background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: radius))
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(.white.opacity(0.7), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
    }
}

// MARK: - الموديل
struct AidCase: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let sketch: String
    let color: Color
    let steps: [String]
}

extension AidCase {
    static let all = [
        AidCase(title: "الإنعاش القلبي الرئوي", icon: "waveform.path.ecg", sketch: "illus_cpr", color: .aidRed, steps: [
            "تأكد من الاستجابة: ربّت على الكتف واسأله، وراقب التنفس.",
            "اتصل بالهلال الأحمر 997.",
            "اضغط على النصف السفلي من عظمة القص 30 ضغطة بعمق 5 سم على الأقل.",
            "أمل الرأس للخلف وأعطه نفسين، مدة كل نفس ثانية.",
            "افحص التنفس كل دقيقتين ولا توقف الإنعاش أكثر من 10 ثوانٍ."
        ]),
        AidCase(title: "الاختناق", icon: "lungs.fill", sketch: "illus_choking", color: .aidRed, steps: [
            "إذا كان يسعل ويتكلم فشجّعه على السعال فقط.",
            "إذا لم يستطع السعال أو الكلام أو التنفس، طبّق الضغطات البطنية (هيمليك).",
            "للبدين أو الحامل استخدم دفعات الصدر.",
            "إذا فقد وعيه أرقده، اتصل بـ 997 وابدأ الإنعاش.",
            "الرضيع: 5 ضربات على الظهر ثم 5 دفعات على الصدر بالتناوب."
        ]),
        AidCase(title: "النزيف الشديد", icon: "drop.fill", sketch: "illus_bleeding", color: .aidRed, steps: [
            "اضغط مباشرة على الجرح.",
            "ارفع العضو النازف إن أمكن.",
            "إن لم يتوقف استخدم نقاط الضغط ثم الأربطة، والعاصبة آخر خيار.",
            "اتصل بـ 997 عند النزيف الغزير.",
            "لا تنزع الجسم المغروس، ثبّته بشاش معقم."
        ]),
        AidCase(title: "الحروق", icon: "flame.fill", sketch: "illus_burns", color: .aidYellow, steps: [
            "أخمد اللهب وأبعد الخطر دون تعريض نفسك للخطر.",
            "أزل الخواتم والملابس غير الملتصقة بالجلد.",
            "برّد الحرق بماء فاتر أو كمادات مبللة.",
            "لا تفتح الفقاعات ولا تضع عليه معجونًا أو دواءً.",
            "الحرق الكيماوي: اغسله بماء وفير، والعين 20 دقيقة."
        ]),
        AidCase(title: "الكسور والخلوع", icon: "bandage.fill", sketch: "illus_fracture", color: .aidGreen, steps: [
            "الأعراض: ألم شديد وتورم وتشوه وعدم القدرة على التحريك.",
            "لا تقوّم الكسر المشوّه، ثبّته كما هو.",
            "في الكسر المفتوح لا تدفع العظم للداخل.",
            "افحص الدورة الدموية قبل التجبير وبعده.",
            "جبّر بجبيرة غير ضاغطة ولا تحرك إصابات العمود الفقري."
        ]),
        AidCase(title: "نوبة الصرع", icon: "bolt.fill", sketch: "illus_seizure", color: .aidGreen, steps: [
            "أبعد عنه الأشياء الصلبة والحادة.",
            "لا توقف التشنج بالقوة.",
            "ابق بجانبه حتى تنتهي النوبة.",
            "إذا لم يكن لديه تاريخ مرضي سابق انقله للمستشفى."
        ]),
        AidCase(title: "التسمم", icon: "exclamationmark.triangle.fill", sketch: "illus_poisoning", color: .aidYellow, steps: [
            "اعرف المادة ومتى ابتُلعت وما الكمية.",
            "تعامل أولًا مع أي حالة تهدد الحياة.",
            "اتصل بـ 997 ثم بمركز السموم.",
            "لا تحفّز القيء، واحتفظ به في علبة نظيفة للطبيب.",
            "إذا فقد وعيه ضعه في وضعية الإفاقة."
        ]),
        AidCase(title: "لدغات الأفاعي والعقارب", icon: "lizard.fill", sketch: "sketch_snake", color: .aidYellow, steps: [
            "اتصل بـ 997 وهدّئ المصاب.",
            "أرقده واجعل موضع اللدغة أخفض من القلب.",
            "لا تجرح المكان ولا تمتص السم ولا تضع ثلجًا.",
            "امنعه من الطعام والشراب."
        ]),
        AidCase(title: "ضربة الشمس", icon: "thermometer.sun.fill", sketch: "illus_heat", color: .aidYellow, steps: [
            "انقل المصاب إلى مكان بارد أو مظلل.",
            "برّد جسمه بماء فاتر والهواء.",
            "اتصل بـ 997 فورًا، فهي أخطر الأمراض الحرارية.",
            "في الإجهاد الحراري أعطه سوائل باردة مع قليل من الملح إن كان واعيًا."
        ]),
        AidCase(title: "النوبة القلبية", icon: "bolt.heart.fill", sketch: "illus_heart", color: .aidRed, steps: [
            "طمئنه واطلب منه الراحة.",
            "فك الملابس الضيقة حول الرقبة والصدر.",
            "ساعده على تناول دوائه الموصوف.",
            "إذا لم يتحسن خلال 3 إلى 5 دقائق اتصل بـ 997.",
            "إذا توقف التنفس والنبض ابدأ الإنعاش فورًا."
        ]),
        AidCase(title: "السكتة الدماغية", icon: "brain.head.profile", sketch: "illus_stroke", color: .aidRed, steps: [
            "العلامات: صداع شديد، صعوبة في الكلام، ضعف الابتسام، انحراف اليد.",
            "اتصل بـ 997 فورًا.",
            "ارفع رأسه وكتفيه وأدره لجانب لتصريف اللعاب.",
            "فك الملابس الضيقة.",
            "لا تعطه أي شيء بالفم."
        ])
    ]
}

// MARK: - الشاشة الرئيسية
struct FirstAidView: View {
    @State private var selected: AidCase?

    var onBack: () -> Void = {}

    var body: some View {
        ZStack {
            Color.aidBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: Space.l) {
                    HStack {
                        AidBackButton(action: onBack)
                        Spacer()
                    }

                    AidHeaderCard()
                        .padding(.bottom, Space.s)

                    ForEach(AidCase.all) { item in
                        Button { selected = item } label: {
                            AidRow(item: item)
                        }
                        .buttonStyle(AidPressStyle())
                    }
                }
                .padding(.horizontal, Space.xxl)
                .padding(.top, Space.xl)
                .padding(.bottom, 40)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .sensoryFeedback(.selection, trigger: selected?.id)
        .sheet(item: $selected) { item in
            AidDetailView(item: item)
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
                .presentationBackground(.ultraThinMaterial)
        }
    }
}

// MARK: - زر الرجوع (زجاجي)
struct AidBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black.opacity(0.6))
                .frame(width: 52, height: 52)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 1))
                .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("رجوع")
    }
}

// MARK: - الكارد الزيتي
struct AidHeaderCard: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.aidOlive)

            Image("aid_kit")
                .resizable()
                .scaledToFit()
                .frame(height: 124)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: 24)

            VStack(alignment: .leading, spacing: Space.s) {
                Text("الإسعافات الأولية")
                    .aidFont(30)
                    .foregroundColor(.aidBackground)

                Text("تصرّف بسرعة، وأنقذ حياة.")
                    .font(.custom("Geeza Pro", size: 20))
                    .foregroundColor(.aidBackground)
            }
            .padding(Space.xl)
        }
        .frame(height: 152)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
    }
}

// MARK: - كارد الحالة
struct AidRow: View {
    let item: AidCase

    var body: some View {
        HStack(spacing: Space.l) {
            Image(systemName: item.icon)
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(item.color)
                .frame(width: 56, height: 56)
                .background(Color.aidCardDark, in: Circle())

            Text(item.title)
                .aidFont(18)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, Space.l)
        .padding(.vertical, Space.m)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color.aidCard, in: RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white.opacity(0.6), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
        .contentShape(RoundedRectangle(cornerRadius: 24))
    }
}

// MARK: - صفحة التفاصيل
struct AidDetailView: View {
    let item: AidCase

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Space.l) {
                illustration

                Text(item.title)
                    .aidFont(20)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                stepsCard
            }
            .padding(.horizontal, Space.xl)
            .padding(.top, Space.xxl)
            .padding(.bottom, 32)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }

    // لو الصورة غير موجودة في Assets يظهر رمز الحالة بدل الفراغ
    // كل الرسومات داخل نفس الإطار، فتظهر بحجم موحد مهما اختلف شكلها
    private var illustration: some View {
        Group {
            if UIImage(named: item.sketch) != nil {
                Image(item.sketch)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: item.icon)
                    .font(.system(size: 56, weight: .semibold))
                    .foregroundColor(item.color)
            }
        }
        .frame(width: 200, height: 128)
    }

    private var stepsCard: some View {
        VStack(alignment: .leading, spacing: Space.l) {
            Text("الإرشادات")
                .aidFont(16)
                .foregroundColor(.black)

            ForEach(item.steps, id: \.self) { step in
                HStack(alignment: .top, spacing: Space.m) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 22))
                        .foregroundColor(.aidGreen)

                    Text(step)
                        .aidFont(20)
                        .foregroundColor(.black)
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(Space.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .aidGlass()
    }
}

// MARK: - ضغطة الكارد
private struct AidPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(duration: 0.25), value: configuration.isPressed)
    }
}

#Preview {
    FirstAidView()
}
