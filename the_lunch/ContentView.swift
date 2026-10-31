
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.aidBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        header

                        VStack(spacing: 16) {
                            NavigationLink {
                                FirstAidView()
                            } label: {
                                MainFeatureCard(
                                    title: "الإسعافات الأولية",
                                    subtitle: "تصرّف بسرعة، وأنقذ حياة.",
                                    systemImage: "cross.case.fill",
                                    color: .aidRed
                                )
                            }

                            NavigationLink {
                                GuidelinesScreen()
                            } label: {
                                MainFeatureCard(
                                    title: "الإرشادات",
                                    subtitle: "تعلّم كيف تتصرف بأمان في أوقات الطوارئ.",
                                    systemImage: "book.fill",
                                    color: .guideOlive
                                )
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    .padding(.bottom, 40)
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("مرحبًا بك")
                .font(.custom("Geeza Pro", size: 32))
                .bold()

            Text("اختر القسم الذي تحتاج إليه")
                .font(.custom("Geeza Pro", size: 20))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct MainFeatureCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(color, in: Circle())

            VStack(alignment: .leading, spacing: AppSpacing.s) {
                Text(title)
                    .font(.custom("Geeza Pro", size: AppFontSize.section))
                    .bold()
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.custom("Geeza Pro", size: 16))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Spacer(minLength: 0)
            Image(systemName: "chevron.left")
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.aidCard, in: RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
    }
}

#Preview {
    ContentView()
}
