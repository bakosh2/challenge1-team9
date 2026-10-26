import SwiftUI


// MARK: - الألوان
//
// extension = إضافة ميزة جديدة لشي موجود أصلاً في Swift.
// هنا نضيف لـ Color طريقة جديدة تفهم أكواد HEX اللي تطلع من سكتش
// مثل "6B746F"، لأن Swift ما يفهمها مباشرة.
// الاستخدام: Color(hex: "F3EDE6")
//
extension Color {

    // init = طريقة لإنشاء لون. تاخذ نص (كود الـ HEX) بدون علامة #
    init(hex: String) {

        // Scanner = أداة تقرأ النص وتحوله لأرقام
        let scanner = Scanner(string: hex)

        // متغير فاضي نخزن فيه الرقم بعد التحويل
        // UInt64 = نوع رقم كبير موجب (يكفي لأي لون)
        var rgb: UInt64 = 0

        // يحوّل النص "6B746F" من نظام HEX إلى رقم عادي ويحطه في rgb
        // علامة & تعني: خزّن النتيجة داخل المتغير نفسه
        scanner.scanHexInt64(&rgb)

        // نبني اللون من 3 قيم: أحمر، أخضر، أزرق (كل قيمة من 0 إلى 1)
        self.init(
            // الأحمر: نزيح الرقم 16 خانة (>> 16) عشان نوصل لأول جزئين،
            // و & 0xFF ياخذ جزء واحد بس (من 0 إلى 255)،
            // و / 255 يحوله لقيمة بين 0 و 1 اللي يفهمها Swift
            red: Double((rgb >> 16) & 0xFF) / 255,

            // الأخضر: نزيح 8 خانات ونأخذ الجزء الأوسط
            green: Double((rgb >> 8) & 0xFF) / 255,

            // الأزرق: ناخذ آخر جزء بدون إزاحة
            blue: Double(rgb & 0xFF) / 255
        )
    }
}


// MARK: - الشاشة الرئيسية
//
// struct = نعرّف شاشة (أو عنصر) جديد.
// : View = يعني إن هذا العنصر يقدر ينعرض على الشاشة.
// ContentView = اسم الشاشة الرئيسية، ولازم يطابق الاسم المستخدم
// في ملف الـ App.
//
struct Screenr1: View {

    // body = محتوى الشاشة. كل View لازم يكون فيه body.
    // some View = يرجّع أي شي ينعرض على الشاشة
    var body: some View {

        // ZStack = يرتب العناصر فوق بعض (طبقات).
        // أول عنصر يكون تحت، والباقي فوقه.
        // نستخدمه عشان نحط اللون كخلفية، والمحتوى فوقه.
        ZStack {
            
            // طبقة الخلفية: اللون الأساسي للتصميم
            Color(hex: "F3EDE6")
            // يخلي اللون يغطي الشاشة كاملة حتى منطقة الساعة
            // والـ Dynamic Island فوق، وشريط الهوم تحت
                .ignoresSafeArea()
            
            // VStack = يرتب العناصر عمودياً (من فوق لتحت)
            // alignment: .leading = محاذاة العناصر للبداية.
            //   بما إن الشاشة RTL (من اليمين لليسار) فالبداية = اليمين
            // spacing: 16 = المسافة بين كل عنصر والثاني
            VStack(alignment: .leading, spacing: 20){
                // ---------- العنوان ----------
                // Text = عنصر يعرض نص
                Text("السلامة البيئية")
                    // الخط: Geeza Pro بحجم 28 (غيّر الرقم لتكبير/تصغير الخط)
                    .font(.custom("Geeza Pro", size: 28))
                    // يخلي الخط سميك
                    .bold()
                    // مسافة من فوق = 60 عشان ينزل تحت الـ Dynamic Island
                    .padding(.top, 60)

                // ---------- الكارد الزيتي ----------
                // نستدعي الكارد اللي عرّفناه تحت في struct HeaderCard
                HeaderCard()

                // ---------- فراغ ----------
                // Spacer = مساحة فاضية، وهنا حددنا ارتفاعها 40
                // عشان نفصل بين الكارد الزيتي والكاردات الأربعة
                Spacer().frame(height: 25)
                // ---------- الكاردات الأربعة ----------
                // نستدعي SafetyCard 4 مرات، كل مرة بقيم مختلفة:
                // title = النص، icon = اسم أيقونة SF Symbol، iconColor = لونها

                // الكارد 1: النار
                // الكارد 1: عنابي
                SafetyCard(
                    title: "أشعل النار بمسؤولية",
                    icon: "flame",
                    iconColor: Color(hex: "BB3939")
                )

                // الكارد 2: زيتي
                SafetyCard(
                    title: "حافظ على نظافة المكان",
                    icon: "trash.slash",
                    iconColor: Color(hex: "4A4A4A")
                )

                // الكارد 3: رصاصي غامق
                SafetyCard(
                    title: "اهتم بالنباتات البرية",
                    icon: "leaf",
                    iconColor: Color(hex: "2B6C07")
                )

                // الكارد 4: بني غامق
                SafetyCard(
                    title: "الحفاظ على الحياة الفطرية",
                    icon: "pawprint",
                    iconColor: Color(hex: "C86306")
                )
                // Spacer بدون حجم = ياخذ كل المساحة الباقية
                // ويدفع كل العناصر لفوق
                Spacer()
            }
            // مسافة 24 من اليمين واليسار عشان الكاردات ما تلتصق بحواف الشاشة
            .padding(.horizontal, 24)
        }
        // أهم سطر للتصميم العربي: يقلب اتجاه الشاشة كلها
        // من اليمين لليسار، فتصير الأيقونة يمين والنص جنبها
        .environment(\.layoutDirection, .rightToLeft)
    }
}


// MARK: - الكارد الزيتي
//
// عنصر مستقل للكارد العلوي (فيه نص وصورة).
// فصلناه في struct لوحده عشان الكود يكون مرتب وأسهل في التعديل.
//
struct HeaderCard: View {
    var body: some View {

        // HStack = يرتب العناصر أفقياً (جنب بعض)
        // بسبب RTL: أول عنصر يكون يمين، والثاني يسار
        // spacing: 12 = المسافة بين النص والصورة
        HStack(spacing: 12) {

            // ---------- النص (يمين) ----------
            // VStack يرتب العنوان والوصف فوق بعض
            // .leading = بداية السطر (اليمين في العربي)
            VStack(alignment: .leading, spacing: 6) {

                // العنوان الرئيسي للكارد
                Text("تخيّم بوعي، واترك الطبيعة أجمل")
                    .font(.custom("Geeza Pro", size: 17))
                    .bold()

                // الوصف الصغير
                Text("استمتع بتجربة التخييم وحافظ على بيئتنا، لتبقى الطبيعة جميلة وآمنة للجميع.")
                    .font(.custom("Geeza Pro", size: 15))
                    // محاذاة النص إذا انكتب على أكثر من سطر (يبدأ من اليمين)
                    .multilineTextAlignment(.leading)
            }
            // لون النص: F3EDE6 (حطيناه على الـ VStack
            // عشان ينطبق على النصين مرة وحدة)
            .foregroundColor(Color(hex: "F3EDE6"))
            // يخلي النص ياخذ كل المساحة الفاضية ويلتصق باليمين
            // والصورة تنزاح لليسار
            .frame(maxWidth: .infinity, alignment: .leading)

            // ---------- الصورة (يسار) ----------
            // الصورة من Assets باسم Camping (لازم الاسم يطابق بالضبط)
            Image("Camping")
                // يسمح بتغيير حجم الصورة (بدونه تبقى بحجمها الأصلي)
                .resizable()
                // تملأ المساحة كاملة وتقص الزايد بدل ما تتشوه
                .scaledToFill()
                // حجم الصورةالي بالكارد الزيتي عرض وطول 0
                .frame(width: 113, height: 76)
                // تدوير زوايا الصورة (12 = قوة الاستدارة)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        // مسافة داخلية 16 بين المحتوى وحافة الكارد
        .padding(16)
        // مسافة الكاردالزيتي طول وعرض
        .frame(width: 356, height: 152)        // لون الكارد الزيتي
        .background(Color(hex: "6B746F"))
        // تأثير الزجاج (glass) فوق اللون.
        // جرّب .thinMaterial أو .regularMaterial لتغيير الوضوح
        .background(.ultraThinMaterial)
        // تدوير زوايا الكارد كله (20 = قوة الاستدارة)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


// MARK: - كارد واحد من الأربعة
//
// كارد قابل لإعادة الاستخدام: كتبناه مرة وحدة ونستدعيه 4 مرات.
// لو عدلت فيه شي ينعكس على الكاردات الأربعة.
//

struct SafetyCard: View {

    let title: String
    let icon: String
    let iconColor: Color

    var body: some View {

        HStack(spacing: 14) {

            // الأيقونة داخل دائرة على اليمين
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(iconColor)
                .frame(width: 56, height: 56)
                .background(Color(hex: "6B746F").opacity(0.155))
                .clipShape(Circle())
                .foregroundColor(iconColor)
                .brightness(-0.15)
            // نص الكارد
            Text(title)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)

            Spacer(minLength: 0)

            // سهم الانتقال على اليسار
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(hex: "6B746F"))
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color(hex: "DCD1C4"))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

#Preview {
    Screenr1()
}

