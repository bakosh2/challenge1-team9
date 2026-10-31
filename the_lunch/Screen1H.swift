import SwiftUI

struct Screen1: View {
    @State private var showHome = false
    @State private var revealLogo = false

    var body: some View {
        ZStack {
            Image("Background1")
                .resizable()
                .scaledToFill()
                .opacity(0.35)
                .ignoresSafeArea()

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 168)
                .mask {
                    Rectangle()
                        .scaleEffect(y: revealLogo ? 1 : 0, anchor: .top)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture { showHome = true }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.2)) {
                revealLogo = true
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(2.6))
            showHome = true
        }
        .fullScreenCover(isPresented: $showHome) {
            HomeScreen()
        }
    }
}

#Preview {
    Screen1()
}
