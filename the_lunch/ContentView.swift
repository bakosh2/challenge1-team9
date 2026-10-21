
import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            VStack {
                Image(.profile)
                    .resizable()
                    .frame(width: 120, height: 120)

                Text("Haneen, \(23)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            Section {
                Text("I’m randa, passionate about technology, AI, and turning ideas into meaningful experiences.")

                Text("I enjoy learning new things, exploring different perspectives, and challenging myself to grow.")

                Text("I love working with others, but I’m also happiest when I can take an idea from zero and bring it to life.")

                Text("I’m always curious, ambitious, and excited to see where the next idea takes me.")
            }
        }
    }
}

#Preview {
    ContentView()
}
