import SwiftUI

// MARK: - الألوان
extension Color {

    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}


// MARK: - الشاشة الرئيسية
struct Screenr1: View {

    var body: some View {

        ZStack {

            // لون خلفية الشاشة
            Color(hex: "F3EDE6")
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {

                // الكارد الزيتي الزجاجي
                HeaderCard()
                    .padding(.top, 60)

                // المسافة بين الكارد الزيتي والكاردات
                Spacer().frame(height: 25)

                // الكارد الأول: النار
                SafetyCard(
                    title: "أشعل النار بمسؤولية",
                    icon: "flame",
                    iconColor: Color(hex: "BB3939")
                )

                // الكارد الثاني: النظافة
                SafetyCard(
                    title: "حافظ على نظافة المكان",
                    icon: "trash.slash",
                    iconColor: Color(hex: "4A4A4A")
                )

                // الكارد الثالث: النباتات
                SafetyCard(
                    title: "اهتم بالنباتات البرية",
                    icon: "leaf",
                    iconColor: Color(hex: "2B6C07")
                )

                // الكارد الرابع: الحياة الفطرية
                SafetyCard(
                    title: "الحفاظ على الحياة الفطرية",
                    icon: "pawprint",
                    iconColor: Color(hex: "C86306")
                )

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}


// MARK: - الكارد الزيتي الزجاجي
struct HeaderCard: View {

    var body: some View {

        ZStack {

            // خلفية الكارد الزجاجية
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "6B746F").opacity(0.85))
                }

            // صورة الجبل من Assets
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

            // النصوص على يمين الكارد
            VStack(alignment: .leading, spacing: 8) {

                // العنوان الرئيسي
                Text("السلامة البيئية")
                    .font(.custom("Geeza Pro", size: 30))
                    .bold()
                    .foregroundColor(Color(hex: "F3EDE6"))

                // العبارة التوضيحية
                Text("تخيّم بوعي، واترك الطبيعة أجمل.")
                    .font(.custom("Geeza Pro", size: 20))
                    .foregroundColor(Color(hex: "F3EDE6"))
                    .multilineTextAlignment(.trailing)

            }
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

            // الأيقونة داخل دائرة
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(iconColor)
                .frame(width: 56, height: 56)
                .background(
                    Color(hex: "6B746F").opacity(0.155)
                )
                .clipShape(Circle())
                .brightness(-0.15)

            // عنوان الكارد
            Text(title)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)

            Spacer(minLength: 0)

            // سهم الانتقال
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
        .shadow(
            color: .black.opacity(0.08),
            radius: 4,
            y: 2
        )
    }
}


// MARK: - Preview
#Preview {
    Screenr1()
}

