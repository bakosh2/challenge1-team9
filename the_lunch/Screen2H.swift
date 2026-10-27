import SwiftUI

// ============================================================
// الشاشة الرئيسية لتطبيق "أسفرت و أنورت"
// المقاسات مأخوذة من التصميم على شاشة iPhone عرضها 393pt
// ============================================================

// MARK: - الألوان (مستخرجة من الصورة)
extension Color {
    init(hex: UInt32) {
        self.init(
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8)  & 0xFF) / 255,
            blue:  Double( hex        & 0xFF) / 255
        )
    }

    static let screenBackground = Color(hex: 0xF2EEE8) // لون خلفية الشاشة (بيج فاتح)
    static let bannerBackground = Color(hex: 0x6B746F) // لون المستطيل الأخضر الرمادي
    static let cardBackground   = Color(hex: 0xFDFCF8) // لون خلفية البطاقات (أبيض مائل للكريمي)
    static let titleColor       = Color(hex: 0x4B5651) // لون عنوان "أسفرت و أنورت"
    static let cardTitle        = Color(hex: 0x1C1C1C) // لون عنوان البطاقة (أسود تقريباً)
    static let cardSubtitle     = Color(hex: 0x6B6B66) // لون الوصف الصغير تحت العنوان
}

// MARK: - بيانات البطاقات
/// يمثل بطاقة واحدة من الست بطاقات
struct SafetyCategory: Identifiable {
    let id = UUID()
    let title: String        // عنوان البطاقة
    let subtitle: String     // الوصف الصغير
    let symbol: String?      // اسم أيقونة SF Symbols (nil يعني نص مثل SOS)
    let color: Color         // لون الأيقونة
}

// ترتيب الصفوف: أول عنصر يطلع يمين لأن الاتجاه RTL
let categories: [SafetyCategory] = [
    // الصف الأول
    SafetyCategory(title: "إرشادات السلامة",
                   subtitle: "تعليمات تساعدك على الوقاية والتصرف الصحيح قبل الكوارث وأثناءها",
                   symbol: "exclamationmark.triangle.fill",
                   color: Color(hex: 0xF0A030)),            // مثلث التحذير البرتقالي (يمين)
    SafetyCategory(title: "أرقام الطوارئ",
                   subtitle: "الوصول السريع إلى أرقام الطوارئ والجهات المختصة",
                   symbol: nil,                              // هنا نص SOS مو أيقونة
                   color: Color(hex: 0x8E1B1B)),             // (يسار)
    // الصف الثاني
    SafetyCategory(title: "الحرائق",
                   subtitle: "إرشادات للتعامل مع الحرائق، والإخلاء الآمن، والحد من مخاطرها",
                   symbol: "flame",
                   color: Color(hex: 0xC8703A)),             // اللهب (يمين)
    SafetyCategory(title: "الإسعافات الأولية",
                   subtitle: "تعرّف على خطوات الإسعافات الأولية للتعامل مع الإصابات والحالات الطارئة",
                   symbol: "cross.case",
                   color: Color(hex: 0xD03A2C)),             // شنطة الإسعاف (يسار)
    // الصف الثالث
    SafetyCategory(title: "السلامة البيئية",
                   subtitle: "استعد للسيول والعواصف وغيرها من الكوارث، وتعلّم كيفية حماية نفسك وعائلتك",
                   symbol: "leaf",
                   color: Color(hex: 0x2F4A1E)),             // النبتة الخضراء (يمين)
    SafetyCategory(title: "الكوارث الطبيعية",
                   subtitle: "تعرّف على المخاطر البيئية وطرق الوقاية",
                   symbol: "cloud.sun.rain",
                   color: Color(hex: 0x5B7FC4))              // سحابة + شمس + مطر (يسار)
]

// MARK: - الشاشة الرئيسية
struct HomeScreen: View {

    // شبكة من عمودين، المسافة بينهم 45pt (كما في التصميم)
    private let columns = [
        GridItem(.flexible(), spacing: 45),
        GridItem(.flexible(), spacing: 45)
    ]

    var body: some View {
        ZStack {
            // خلفية الشاشة كاملة
            Color.screenBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // 1) عنوان الشاشة: "أسفرت و أنورت" (أعلى اليمين)
                //    هذا اسم التطبيق. غيّره هنا إذا تبي اسم ثاني.
                Text("أسفرت و أنورت")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.titleColor)
                    .padding(.top, 24)

                // 2) المستطيل الأخضر (بنر الشعار والعبارة)
                BannerView()
                    .padding(.top, 22)
                //هناالكارد القزاز
                    .background(.ultraThinMaterial)

                // 3) شبكة البطاقات الست (بينها وبين البنر مسافة 79pt)
                LazyVGrid(columns: columns, spacing: 23) {
                    ForEach(categories) { item in
                        CategoryCard(item: item)
                    }
                }
                .padding(.top, 79)

                Spacer()
            }
            .padding(.horizontal, 21) // الهامش الجانبي للشاشة
        }
        // نخلي الشاشة عربية: النص يبدأ من اليمين وترتيب العناصر يمين → يسار
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
    }
}

// MARK: - المستطيل الأخضر (البنر)
struct BannerView: View {
    var body: some View {
        
        HStack(spacing: 24) {
            
            // أ) مكان الشعار (يمين البنر)
            //    أضف صورة الشعار في Assets.xcassets باسم "AppLogo"
            //    إذا ما لقى الصورة يعرض مربع مؤقت بعلامة صورة.
            LogoPlaceholder()
                .frame(width: 90, height: 110)

            // ب) العبارة الدعائية (يسار الشعار)
            //    السطر الأول واللي بعده مكتوبين مثل التصميم
            VStack(alignment: .leading, spacing: 14) {
                
                Text("رفيقك في الدرب")
                Text("عضيدك في الشدّه")
                //            .background(.ultraThinMaterial)

                
            }
            .font(.system(size: 22, weight: .regular))
            .foregroundColor(.white.opacity(0.92))
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .frame(height: 162)                       // ارتفاع البنر
        .background(Color.bannerBackground)       // اللون الأخضر الرمادي
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        
    }
}

// MARK: - مكان الشعار
struct LogoPlaceholder: View {
    var body: some View {
        if UIImage(named: "Logo") != nil {
            // شعارك الحقيقي (بعد إضافته في Assets)
            Image("Logo")
                .resizable()
                .scaledToFit()
        } else {
            // مكان مؤقت يوضح وين يروح الشعار والاسم
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                .foregroundColor(.white.opacity(0.6))
                .overlay(
                    VStack(spacing: 6) {
                        Image(systemName: "photo")
                        Text("الشعار هنا")
                            .font(.system(size: 11))
                    }
                    .foregroundColor(.white.opacity(0.7))
                )
        }
    }
}

// MARK: - بطاقة واحدة
struct CategoryCard: View {
    let item: SafetyCategory

    var body: some View {
        // النص يبدأ من اليمين لأن .leading في RTL = يمين
        VStack(alignment: .leading, spacing: 6) {

            // أ) الأيقونة (أعلى يمين البطاقة)
            iconView
                .frame(height: 34, alignment: .leading)

            // ب) عنوان البطاقة (خط عريض)
            Text(item.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.cardTitle)

            // ج) الوصف الصغير (رمادي)
            Text(item.subtitle)
                .font(.system(size: 10.5))
                .foregroundColor(.cardSubtitle)
                .lineSpacing(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 115)                        // ارتفاع البطاقة
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2) // ظل خفيف
    }

    // الأيقونة: إما SF Symbol أو نص SOS
    @ViewBuilder
    private var iconView: some View {
        if let symbol = item.symbol {
            Image(systemName: symbol)
                .font(.system(size: 30, weight: .regular))
                .foregroundColor(item.color)
        } else {
            // كلمة SOS بخط عريض ضيّق باللون الأحمر الداكن
            Text("SOS")
                .font(.system(size: 36, weight: .heavy).width(.condensed))
                .foregroundColor(item.color)
        }
    }
}

// MARK: - المعاينة
#Preview {
    HomeScreen()
}
