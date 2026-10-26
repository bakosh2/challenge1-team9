//
//  Screenr2.swift
//  the_lunch
//
//  Created by Randa Alqahtani on 15/05/1448 AH.
//

import SwiftUI

// MARK: - الشاشة الثانية
struct Screenr2: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {

        ZStack {

            // خلفية الشاشة
            Color(hex: "F3EDE6")
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // زر الرجوع
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 46, height: 46)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }

                    Spacer()
                }
                .padding(.top, 15)

                // MARK: - الكارد الزيتي
                ZStack {

                    // الخلفية الزجاجية
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    Color(hex: "6B746F")
                                        .opacity(0.85)
                                )
                        }

                    // صورة النار من Assets
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

                    // العنوان في المنتصف مع رفعه للأعلى
                    Text("إرشادات السلامة البيئية")
                        .font(.custom("Geeza Pro", size: 25))
                        .bold()
                        .foregroundColor(Color(hex: "F3EDE6"))
                        .multilineTextAlignment(.center)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                        .offset(y: -25)
                }
                .frame(height: 152)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 60)

                // المسافة بين الكاردين
                Spacer().frame(height: 80)

                // MARK: - الكارد البيج
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

                Spacer().frame(height: 15)
            }
            .padding(.horizontal, 20)
        }
        .toolbar(.hidden, for: .navigationBar)
        .environment(\.layoutDirection, .rightToLeft)
    }
}


// MARK: - صف الإرشادات
struct GuideRow: View {

    let text: String

    var body: some View {

        HStack(alignment: .top, spacing: 10) {

            // علامة الصح الخضراء على اليمين
            Image(systemName: "checkmark.circle")
                .font(.system(size: 21))
                .foregroundColor(Color(hex: "2B6C07"))

            // النص العربي بمحاذاة اليمين
            Text(text)
                .font(.custom("Geeza Pro", size: 18))
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .environment(\.layoutDirection, .rightToLeft)
    }
}


// MARK: - Preview
#Preview {
    NavigationStack {
        Screenr2()
    }
}

