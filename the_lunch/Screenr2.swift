//
//  Screenr2.swift
//  the_lunch
//
//  Created by Randa Alqahtani on 15/05/1448 AH.
//


import SwiftUI

// MARK: - الشاشة الثانية
struct Screenr2: View {

    @Environment(\.dismiss) private var dismiss
    @State private var showGuides = false

    var body: some View {

        ZStack {

            Color(hex: "F3EDE6").ignoresSafeArea()

            VStack(spacing: 0) {

                // زر الرجوع الزجاجي
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "616152"))
                            .frame(width: 58, height: 58)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.white.opacity(0.7), lineWidth: 1)
                            }
                            .shadow(
                                color: .black.opacity(0.15),
                                radius: 5,
                                y: 3
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .padding(.top, 15)

                // الكارد الزيتي
                ZStack {

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "616152"))

                    Image("FireCamp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .opacity(0.65)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )

                    Text("إرشادات السلامة البيئية")
                        .font(.custom("Geeza Pro", size: 18))
                        .bold()
                        .foregroundColor(Color(hex: "F3EDE6"))
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .leading
                        )
                        .padding(20)
                }
                .frame(width: 356, height: 152)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 60)

                // المسافة بين الكاردين
                Spacer().frame(height: 80)

                // الكارد البيج المتحرك
                VStack(spacing: 60) {

                    GuideRow(
                        text: "أطفئ النار تمامًا قبل المغادرة، وتأكد من عدم وجود جمر مشتعل."
                    )

                    GuideRow(
                        text: "أبعدها عن النباتات والأعشاب والمواد القابلة للاشتعال."
                    )

                    GuideRow(
                        text: "أشعل النار في الأماكن المسموح بها والمخصصة لذلك."
                    )

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 45)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "DCD1C4"))
                .clipShape(RoundedRectangle(cornerRadius: 22))

                // حركة الظهور من الأسفل
                .offset(y: showGuides ? 0 : 500)
                .opacity(showGuides ? 1 : 0)

                Spacer().frame(height: 15)
            }
            .padding(.horizontal, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
        .environment(\.layoutDirection, .rightToLeft)

        // تشغيل الحركة تلقائيًا عند فتح الشاشة
        .onAppear {
            showGuides = false

            withAnimation(.easeOut(duration: 0.7).delay(0.15)) {
                showGuides = true
            }
        }
    }
}

// MARK: - صف الإرشادات
struct GuideRow: View {

    let text: String

    var body: some View {

        HStack(alignment: .top, spacing: 10) {

            Image(systemName: "mountain.2.circle")
                .font(.system(size: 21))
                .foregroundColor(Color(hex: "626557"))

            Text(text)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        Screenr2()
    }
}

