import SwiftUI

struct EmergencyNumber: Identifiable {
    let id = UUID()
    let title: String
    let number: String
}

struct EmergencyScreen: View {
    @Environment(\.dismiss) private var dismiss

    private let items = [
        EmergencyNumber(title: "الطوارئ", number: "911"),
        EmergencyNumber(title: "الدفاع المدني", number: "998"),
        EmergencyNumber(title: "فريق إنجاد", number: "920018911")
    ]

    var body: some View {
        ZStack {
            Color.screenBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: AppSpacing.xxl) {
                    ForEach(items) { item in
                        EmergencyRow(item: item)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
        }
        .tint(Color.guideOlive)
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
    }
}

struct EmergencyRow: View {
    let item: EmergencyNumber

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(item.title)
                .font(.custom("Geeza Pro", size: AppFontSize.body))
                .bold()
                .foregroundStyle(.primary)

            Link(destination: URL(string: "tel://\(item.number)")!) {
                HStack {
                    Image(systemName: "phone")
                        .foregroundStyle(Color.topicEmergency)
                    Spacer()
                    Text(item.number)
                        .font(.custom("Geeza Pro", size: AppFontSize.title))
                        .bold()
                        .foregroundStyle(.primary)
                    Spacer()
                }
                .padding(.horizontal, 24)
                        .frame(height: 80)
                .background(Color.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 28))
            }
            .buttonStyle(.plain)
        }
    }
}

struct GlassButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.guideOlive)
                .frame(width: 48, height: 48)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay { Circle().stroke(.white.opacity(0.7), lineWidth: 1) }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EmergencyScreen()
}
