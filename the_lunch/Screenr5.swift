//
//  Screenr5.swift
//  the_lunch
//
//  Created by Randa Alqahtani on 16/05/1448 AH.
//

import SwiftUI

// MARK: - الشاشة الخامسة
struct Screenr5: View {

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
                                .fill(Color(hex: "6B746F").opacity(0.85))
                        }

                    // صورة النباتات من Assets

                    // صورة النباتات أسفل يسار الكارد
                    Image("PlantsCamp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .opacity(0.65)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                        .padding(.leading, 8)
                        .padding(.bottom, 5)


                    // العنوان في المنتصف ومرفوع قليلًا
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
                        text: "لا تقطع الأشجار أو تقتلع النباتات البرية."
                    )

                    GuideRow(
                        text: "تجنب دهس النباتات بالسيارة."
                    )

                    GuideRow(
                        text: "لا تقطع الأغصان الحية ولا تستخدم الأشجار الحية حطبًا لإشعال النار."
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

// MARK: - Preview
#Preview {
    NavigationStack {
        Screenr5()
    }
}

