
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

// MARK: - الشاشة الأولى
struct Screenr1: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "F3EDE6").ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {

                    HeaderCard()
                        .padding(.top, 60)

                    Spacer().frame(height: 25)

                    // الانتقال إلى شاشة إرشادات النار
                    NavigationLink(destination: Screenr2()) {
                        SafetyCard(
                            title: "أشعل النار بمسؤولية",
                            icon: "flame",
                            iconColor: Color(hex: "BB3939")
                        )
                    }
                    .buttonStyle(.plain)

                   
                    NavigationLink(destination: Screenr3()) {
                        SafetyCard(
                            title: "حافظ على نظافة المكان",
                            icon: "trash.slash",
                            iconColor: Color(hex: "4A4A4A")
                        )
                    }
                    .buttonStyle(.plain)


              
                    // الكارد الثالث: النباتات البرية
                    NavigationLink(destination: Screenr5()) {
                        SafetyCard(
                            title: "اهتم بالنباتات البرية",
                            icon: "leaf",
                            iconColor: Color(hex: "2B6C07")
                        )
                    }
                    .buttonStyle(.plain)


                    
                    // الكارد الرابع: الحياة الفطرية
                    NavigationLink(destination: Screenr4()) {
                        SafetyCard(
                            title: "الحفاظ على الحياة الفطرية",
                            icon: "pawprint",
                            iconColor: Color(hex: "C86306")
                        )
                    }
                    .buttonStyle(.plain)


                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - الكارد الزيتي
struct HeaderCard: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "6B746F").opacity(0.85))
                }

            // صورة الجبل
            Image("c1")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .opacity(0.65)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .bottomTrailing)

            VStack(alignment: .leading, spacing: 8) {
                Text("السلامة البيئية")
                    .font(.custom("Geeza Pro", size: 30))
                    .bold()

                Text("تخيّم بوعي، واترك الطبيعة أجمل.")
                    .font(.custom("Geeza Pro", size: 20))
                    .multilineTextAlignment(.trailing)
            }
            .foregroundColor(Color(hex: "F3EDE6"))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
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
                .background(Color(hex: "6B746F").opacity(0.155))
                .clipShape(Circle())
                .brightness(-0.15)

            Text(title)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)

            Spacer(minLength: 0)

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

