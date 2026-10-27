//
//  Screen1.swift 2.swift
//  the_lunch
//
//  Created by Haneen on 15/05/1448 AH.
//



import SwiftUI

struct Screen1: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // خلفية الجبال
                Image("Background1")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height*(1.9)
                    )
                    .clipped()

                // الشعار فوق الخلفية
                
                VStack(spacing: 4) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.38)

                    //ادرجت اللوقو مع النص ك صورة
                }

                
                
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Screen1()
}
