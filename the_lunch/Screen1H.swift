import SwiftUI

struct Screen1: View {
    @State private var showHome = false

    var body: some View {
        ZStack {
            Image("Background1")
                .resizable()
                .scaledToFill()
                .opacity(0.55)
                .ignoresSafeArea()

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 168)
        }
        .contentShape(Rectangle())
        .onTapGesture { showHome = true }
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
