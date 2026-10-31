import SwiftUI

struct UnifiedBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.guideOlive)
                .frame(width: 48, height: 48)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white.opacity(0.7), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.15), radius: 5, y: 3)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("رجوع")
    }
}
