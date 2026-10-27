//
//  Screen3H.swift
//  the_lunch
//
//  Created by Haneen on 15/05/1448 AH.
//
import SwiftUI

// ============================================================
// شاشة "أرقام الطوارئ"
// التصميم الأصلي: iPhone 17 بمقاس 402 × 874
// ملاحظة: هذا الملف يستخدم Color(hex:) المعرّفة في HomeScreen.swift
// فلازم يكون الملفين في نفس المشروع.
// ============================================================

// MARK: - الألوان (من لوحة Colors في برنامج التصميم)
extension Color {
    static let emergencyBackground = Color(hex: 0xF2EEE8)                  // خلفية الشاشة (Fill: F3EDE6)
    static let emergencyPill       = Color(hex: 0xA9514E).opacity(0.86)    // لون المستطيلات الحمراء (A9514E بشفافية 86%)
    static let emergencyText       = Color.black                           // لون العنوان والأرقام (000000)
}

// MARK: - بيانات الأرقام
/// يمثل رقم طوارئ واحد: اسم الجهة + الرقم
struct EmergencyContact: Identifiable {
    let id = UUID()
    let name: String     // اسم الجهة (يطلع يمين المستطيل)
    let number: String   // الرقم (يطلع يسار الاسم)
}

let emergencyContacts: [EmergencyContact] = [
    EmergencyContact(name: "الطوارئ",       number: "911"),        // المستطيل الأول
    EmergencyContact(name: "الدفاع المدني", number: "998"),        // المستطيل الثاني
    EmergencyContact(name: "فريق إنجاد",    number: "920018911")   // المستطيل الثالث
]

// MARK: - الشاشة
struct EmergencyNumbersScreen: View {

    // للرجوع للشاشة السابقة عند الضغط على زر السهم
    @Environment(\.dismiss) private var dismiss
    // لفتح تطبيق الاتصال عند الضغط على المستطيل
    @Environment(\.openURL) private var openURL

    var body: some View {
        ZStack {
            // خلفية الشاشة كاملة
            Color.emergencyBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // 1) زر الرجوع (الدائرة اللي فيها سهم، أعلى اليمين)
                //    في الاتجاه العربي الرجوع يكون سهم لليمين (chevron.right)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 49, height: 49)                       // قطر الدائرة
                        .background(
                            Circle()
                                .fill(Color(white: 0.86))                   // رمادي فاتح زجاجي
                                .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
                        )
                }
                .padding(.top, 8)

                // 2) عنوان الشاشة "أرقام الطوارئ" (أسود، عريض، يبدأ من اليمين)
                Text("أرقام الطوارئ")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.emergencyText)
                    .padding(.top, 24)

                // 3) المستطيلات الحمراء الثلاثة (الأرقام)
                VStack(spacing: 57) {                                       // المسافة بين المستطيلات
                    ForEach(emergencyContacts) { contact in
                        EmergencyPill(contact: contact) {
                            // عند الضغط: يفتح الاتصال بالرقم
                            if let url = URL(string: "tel://\(contact.number)") {
                                openURL(url)
                            }
                        }
                    }
                }
                .padding(.top, 86)                                          // المسافة بين العنوان وأول مستطيل
                .padding(.horizontal, -10)                                  // المستطيلات أعرض من هامش العنوان (عرضها 376)

                Spacer()
            }
            .padding(.horizontal, 24)                                       // هامش العنوان وزر الرجوع من اليمين
        }
        // 4) زر الشعار الدائري (أسفل اليمين) فوق كل شي
        .overlay(alignment: .bottomTrailing) {
            LogoButton()
                .padding(.trailing, 32)
                .padding(.bottom, 28)
                .ignoresSafeArea(edges: .bottom)
        }
        // نخلي الشاشة عربية: النص يبدأ من اليمين وترتيب العناصر يمين ← يسار
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
        .navigationBarBackButtonHidden(true)                                // نخفي زر الرجوع الافتراضي ونستخدم زرنا
    }
}

// MARK: - المستطيل الأحمر (بطاقة رقم واحد)
struct EmergencyPill: View {
    let contact: EmergencyContact
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 22) {

                // أ) اسم الجهة (يمين المستطيل): "الطوارئ" / "الدفاع المدني" / "فريق إنجاد"
                Text(contact.name)
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.emergencyText)
                    .frame(width: 100, alignment: .leading)   // عمود ثابت عشان الأرقام تصف تحت بعض

                // ب) الرقم (يسار الاسم): خط ضخم وعريض
                Text(contact.number)
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.emergencyText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)                  // لو الرقم طويل يصغر بدل ما يقص
                    .environment(\.layoutDirection, .leftToRight) // الأرقام تنقرأ يسار ← يمين

                Spacer(minLength: 0)
            }
            .padding(.leading, 37)                            // مسافة بين الحافة اليمنى للمستطيل والاسم
            .padding(.trailing, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 94)                                // ارتفاع المستطيل
            .background(Capsule().fill(Color.emergencyPill))  // شكل كبسولة (زواياه نصف دائرية كاملة)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - زر الشعار الدائري (أسفل اليمين)
struct LogoButton: View {
    var body: some View {
        ZStack {
            // الدائرة البيضاء الزجاجية
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(Circle().fill(Color.white.opacity(0.55)))
                .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)

            // الشعار: إذا أضفت صورة باسم "AppLogo" في Assets تطلع هنا
            // وإلا يطلع رمز الجبال المؤقت من SF Symbols
            if UIImage(named: "AppLogo") != nil {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            } else {
                Image(systemName: "mountain.2")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
            }
        }
        .frame(width: 49, height: 49)                         // قطر الزر
    }
}

// MARK: - المعاينة
#Preview {
    NavigationStack {
        EmergencyNumbersScreen()
    }
}
