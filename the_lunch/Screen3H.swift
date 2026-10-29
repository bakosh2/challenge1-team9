import SwiftUI

// MARK: - البيانات
struct EmergencyNumber: Identifiable {
    let id = UUID()
    let title: String
    let number: String
}

// MARK: - الشاشة
struct EmergencyScreen: View {

    @Environment(\.dismiss) private var dismiss

    private let items: [EmergencyNumber] = [
        .init(title: "الطوارئ", number: "911"),
        .init(title: "الدفاع المدني", number: "998"),
        .init(title: "فريق إنجاد", number: "920018911")
    ]

    var body: some View {
        ZStack {
            Color(hex: 0xF3EDE6).ignoresSafeArea()

            VStack(spacing: 0) {

                // زر الرجوع (أعلى اليمين): يرجع لـ HomeScreen
                HStack {
                    GlassButton(icon: "chevron.backward") { dismiss() }
                    Spacer()
                }
                .padding(.top, 20)

                Spacer()

                // الصفوف في منتصف الشاشة
                VStack(alignment: .leading, spacing: 28) {
                    ForEach(items) { EmergencyRow(item: $0) }
                }

                Spacer()

                // مساحة فارغة بمقدار زر الرجوع عشان تبقى الصفوف متوازنة بالنص
                Color.clear
                    .frame(height: 58)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 24)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
    }
}

// MARK: - صف (عنوان + كارد الرقم)
struct EmergencyRow: View {
    let item: EmergencyNumber

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(item.title)
                .font(.custom("Geeza Pro", size: 20))
                .bold()
                .foregroundStyle(Color(hex: 0x282828))

            Link(destination: URL(string: "tel://\(item.number)")!) {
                ZStack(alignment: .leading) {

                    Text(item.number)
                        .font(.custom("Geeza Pro", size: 30))
                        .bold()
                        .foregroundStyle(Color(hex: 0x282828))
                        .frame(maxWidth: .infinity)

                    Image(systemName: "phone")
                        .font(.system(size: 25))
                        .foregroundColor(Color(hex: 0xBB3939))
                        .padding(.leading, 24)
                }
                .frame(height: 84)
                .background(Color(hex: 0xDCD1C4))
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - الزر الزجاجي
struct GlassButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(Color(hex: 0x616152))
                .frame(width: 58, height: 58)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay { Circle().stroke(.white.opacity(0.7), lineWidth: 1) }
                .shadow(color: .black.opacity(0.15), radius: 5, y: 3)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        EmergencyScreen()
    }
}
