//
//  ContentView 3.swift
//  the_lunch
//
//  Created by Randa Alqahtani on 15/05/1448 AH.
//



import SwiftUI

struct ContentView: View {

    private let backgroundColor = Color(
        red: 233/255, green: 225/255, blue: 215/255
    )

    private let darkGreen = Color.black

    private let sageGreen = Color(
        red: 107/255, green: 116/255, blue: 111/255
    )

    private let cardColor = Color(
        red: 220/255, green: 209/255, blue: 196/255
    )

    private let headerTextColor = Color(
        red: 243/255, green: 237/255, blue: 230/255
    )

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .trailing, spacing: 0) {

                        // العنوان الرئيسي
                        Text("السلامة البيئية")
                            .font(.system(size: 29, weight: .bold))
                            .foregroundStyle(darkGreen)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 24)
                            .padding(.bottom, 28)

                        // بطاقة التخييم
                        HStack(spacing: 14) {

                            Image("Camping")
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geometry.size.width * 0.34,
                                    height: 118
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )

                            VStack(alignment: .trailing, spacing: 10) {
                                Text("تخيم بوعي، واترك الطبيعة أجمل")
                                    .font(.system(size: 19, weight: .bold))
                                    .foregroundStyle(headerTextColor)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fixedSize(
                                        horizontal: false,
                                        vertical: true
                                    )

                                Text("استمتع بتجربة التخييم وحافظ على بيئتنا، لتبقى الطبيعة جميلة دائماً للجميع.")
                                    .font(.system(size: 11))
                                    .foregroundStyle(headerTextColor)
                                    .multilineTextAlignment(.trailing)
                                    .lineSpacing(3)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fixedSize(
                                        horizontal: false,
                                        vertical: true
                                    )
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(sageGreen.opacity(0.88))
                                .background(
                                    .ultraThinMaterial,
                                    in: RoundedRectangle(cornerRadius: 25)
                                )
                        }
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )

                        // خيارات السلامة البيئية
                        VStack(spacing: 18) {

                            menuItem(
                                title: "أشعل النار بمسؤولية",
                                icon: "flame",
                                iconColor: Color(
                                    red: 127/255, green: 20/255, blue: 20/255
                                )
                            )

                            menuItem(
                                title: "حافظ على نظافة المكان",
                                icon: "trash",
                                iconColor: Color(
                                    red: 101/255, green: 91/255, blue: 85/255
                                )
                            )

                            menuItem(
                                title: "اهتم بالنباتات البرية",
                                icon: "leaf",
                                iconColor: Color(
                                    red: 29/255, green: 57/255, blue: 13/255
                                )
                            )

                            menuItem(
                                title: "الحفاظ على الحياة الفطرية",
                                icon: "pawprint",
                                iconColor: Color(
                                    red: 124/255, green: 75/255, blue: 45/255
                                )
                            )
                        }
                        .padding(.top, 48)

                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 24)
                    .frame(maxWidth: 520)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .preferredColorScheme(.light)
    }

    // تصميم كل خيار
    private func menuItem(
        title: String,
        icon: String,
        iconColor: Color
    ) -> some View {

        HStack(spacing: 14) {

            // الأيقونة
            Image(systemName: icon)
                .font(.system(size: 25, weight: .regular))
                .foregroundStyle(iconColor)
                .frame(width: 56, height: 56)
                .background(sageGreen.opacity(0.20))
                .clipShape(Circle())

            // النص العربي
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.black)
                .multilineTextAlignment(.trailing)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)

            // سهم الانتقال
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(sageGreen)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .contentShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    ContentView()
}
