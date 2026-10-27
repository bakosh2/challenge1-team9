//
//  Screen4H.swift
//  the_lunch
//
//  Created by Haneen on 15/05/1448 AH.
//

import SwiftUI

// ============================================================
// شاشة "السلامة البيئية"
// التصميم الأصلي: 402 × 874
// هذا الملف يعتمد على:
//   - HomeScreen.swift            ← Color(hex:) و .bannerBackground و .cardBackground
//   - EmergencyNumbersScreen.swift ← LogoButton (زر الشعار الدائري)
// فلازم الثلاثة ملفات يكونون في نفس المشروع.
// ============================================================

// MARK: - الألوان
extension Color {
    static let envBackground = Color(hex: 0xF3EDE6)                       // خلفية الشاشة (Fill: F3EDE6)
    static let envText       = Color(hex: 0x131513)                       // لون نص البطاقات (131513)
    static let envWatermark  = Color(hex: 0xD9C08C).opacity(0.5)          // لون الشعار الكبير الباهت بالخلفية (بيج ذهبي)
}

// MARK: - بيانات البطاقات
/// يمثل نصيحة واحدة: النص + الأيقونة + لون الأيقونة
struct EnvironmentTip: Identifiable {
    let id = UUID()
    let text: String      // نص النصيحة داخل البطاقة
    let symbol: String    // اسم أيقونة SF Symbols (تطلع يمين البطاقة)
    let color: Color      // لون الأيقونة
}

let environmentTips: [EnvironmentTip] = [
    EnvironmentTip(text: "أشعل النار بمسؤولية",
                   symbol: "flame",              // أيقونة اللهب الأحمر
                   color: Color(hex: 0xB83A2E)),
    EnvironmentTip(text: "حافظ على نظافة المكان",
                   symbol: "trash.slash",        // سلة المهملات المشطوبة (رمادية)
                   color: Color(hex: 0x6E6E6A)),
    EnvironmentTip(text: "اهتمام بالنباتات البرية",
                   symbol: "leaf",               // ورقة الشجر الخضراء
                   color: Color(hex: 0x3C6B1F)),
    EnvironmentTip(text: "الحفاظ على الحياة الفطرية",
                   symbol: "pawprint",           // أثر الحيوان (برتقالي)
                   color: Color(hex: 0xC8681E))
]

// MARK: - الشاشة
struct EnvironmentalSafetyScreen: View {

    // للرجوع للشاشة السابقة
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            // 1) خلفية الشاشة
            Color.envBackground.ignoresSafeArea()

            // 2) الشعار الكبير الباهت (علامة الجبال) خلف المحتوى
            //    يبدأ من اليسار ويطلع جزء منه برا الشاشة من اليمين، مثل التصميم.
            //    لو عندك صورة الشعار حطها باسم "AppLogo" بدل الرمز المؤقت.
            WatermarkLogo()
                .padding(.leading, 40)                                    // بعده عن حافة الشاشة اليسرى
                .padding(.top, 134)                                       // بعده عن أعلى الشاشة
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .environment(\.layoutDirection, .leftToRight)             // عشان topLeading تكون اليسار فعلاً
                .ignoresSafeArea()
                .clipped()
                .allowsHitTesting(false)

            // 3) المحتوى
            VStack(alignment: .leading, spacing: 0) {

                // أ) زر الرجوع (الدائرة اللي فيها سهم، أعلى اليمين)
                BackCircleButton { dismiss() }
                    .padding(.horizontal, 26)
                    .padding(.top, 19)

                // ب) المستطيل الأخضر الرمادي: عنوان الشاشة + العبارة التحفيزية
                VStack(alignment: .leading, spacing: 4) {
                    Text("السلامة البيئية")                               // العنوان الكبير الأبيض
                        .font(.system(size: 32, weight: .bold))
                    Text("تخيّم بوعي، واترك الطبيعة أجمل")                  // العبارة تحت العنوان
                        .font(.system(size: 18, weight: .regular))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, alignment: .leading)          // .leading = يمين في العربي
                .frame(height: 94)                                        // ارتفاع المستطيل
                .background(Color.bannerBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.horizontal, 23)
                .padding(.top, 15)

                // ج) البطاقات الأربع (نصيحة + أيقونة)
                VStack(spacing: 47) {                                     // المسافة بين البطاقات
                    ForEach(environmentTips) { tip in
                        TipRow(tip: tip)
                    }
                }
                .padding(.top, 97)                                        // المسافة بين المستطيل الأخضر وأول بطاقة

                Spacer()
            }
        }
        // 4) زر الشعار الدائري (أسفل اليمين) نفس الموجود في شاشة الطوارئ
        .overlay(alignment: .bottomTrailing) {
            LogoButton()
                .padding(.trailing, 28)
                .padding(.bottom, 28)
                .ignoresSafeArea(edges: .bottom)
        }
        // الاتجاه عربي: النص يبدأ من اليمين
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - صف نصيحة واحدة (الأيقونة + البطاقة)
struct TipRow: View {
    let tip: EnvironmentTip

    var body: some View {
        HStack(spacing: 13) {

            // أ) الأيقونة: تطلع يمين البطاقة وبرا حدودها
            Image(systemName: tip.symbol)
                .font(.system(size: 34, weight: .regular))
                .foregroundColor(tip.color)
                .frame(width: 30)

            // ب) البطاقة البيضاء الكريمية اللي فيها النص
            Text(tip.text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.envText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)                                  // لو النص طويل يصغر شوي
                .padding(.leading, 30)                                    // مسافة النص من يمين البطاقة
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 61)                                        // ارتفاع البطاقة
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.cardBackground)
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                )
        }
        .padding(.leading, 30)                                            // مسافة البطاقة من يسار الشاشة
        .padding(.trailing, 17)                                           // مسافة الأيقونة من يمين الشاشة
    }
}

// MARK: - الشعار الكبير الباهت في الخلفية
struct WatermarkLogo: View {
    var body: some View {
        if UIImage(named: "AppLogo") != nil {
            Image("AppLogo")
                .resizable()
                .renderingMode(.template)                                 // نلونه بلون الشعار الباهت
                .scaledToFit()
                .foregroundColor(.envWatermark)
                .frame(width: 360, height: 300)
        } else {
            // رمز مؤقت يشبه علامة الجبال
            Image(systemName: "tent.fill")
            //هنا سمك الشعار الخلفي
                .font(.system(size: 288, weight: .light))
                .foregroundColor(.envWatermark)
                .frame(width: 250, height: 300)
            
        }
    }
}

// MARK: - زر الرجوع الدائري
/// نفس زر الرجوع في شاشة الطوارئ لكن بقطر 40 حسب هذا التصميم.
/// (لو تبي تستخدمه في الشاشتين، خله ملف مشترك وأضف قطر الدائرة كمتغير.)
struct BackCircleButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")                            // الرجوع في العربي = سهم لليمين
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color(white: 0.86))
                        .shadow(color: .black.opacity(0.10), radius: 5, x: 0, y: 2)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - المعاينة
#Preview {
    NavigationStack {
        EnvironmentalSafetyScreen()
    }
}
