//
//  safty introdution 1.swift
//  the_lunch
//
//  Created by Ebtihal Alomari on 15/05/1448 AH.
//

import Foundation
import SwiftUI

// MARK: - Colors

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    static let darkGreen = Color(hex: 0x293B39)
    static let grayGreen = Color(hex: 0x475B5A)
    static let beige = Color(hex: 0xB9A99A)
    static let brown = Color(hex: 0x9A7365)
    static let offWhite = Color(hex: 0xF3EDE6)
    static let sand = Color(hex: 0xE3D8CE)
}

// MARK: - Model

struct AidCase: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let steps: [String]
}

let aidCases = [
    AidCase(title: "لدغات الثعابين والعقارب", icon: "lizard.fill", steps: [
        "ابتعد عن مصدر الخطر وحافظ على الهدوء",
        "اتصل بالإسعاف 997",
        "ثبّت الطرف المصاب وأزل الخواتم والملابس الضيقة",
        "لا تشق الجرح ولا تمصه"
    ]),
    AidCase(title: "الإغماء", icon: "figure.fall", steps: [
        "أنم المصاب على ظهره",
        "ارفع ساقيه قليلاً",
        "فك الملابس الضيقة",
        "إذا لم يستفق خلال دقيقة اتصل بـ 997"
    ]),
    AidCase(title: "الاختناق", icon: "lungs.fill", steps: [
        "حدّد نوع الانسداد",
        "طبّق الضغطات البطنية (هيمليك)",
        "إذا فقد المصاب وعيه ابدأ الإنعاش واتصل بـ 997"
    ]),
    AidCase(title: "النزيف", icon: "drop.fill", steps: [
        "اضغط على الجرح بقطعة قماش نظيفة",
        "لا ترفع القماش، أضف فوقه إذا تشبّع",
        "ارفع الطرف المصاب",
        "إذا لم يتوقف النزيف اتصل بـ 997"
    ]),
    AidCase(title: "الحروق", icon: "flame.fill", steps: [
        "أبعد المصاب عن مصدر الحرارة",
        "برّد الحرق بماء جارٍ لمدة 20 دقيقة",
        "غطّه بشاش نظيف ولا تفقع الفقاعات"
    ]),
    AidCase(title: "ضربة الشمس", icon: "sun.max.fill", steps: [
        "انقل المصاب إلى مكان مظلل",
        "اتصل بالإسعاف 997",
        "برّد جسمه بقماش مبلل",
        "أعطه ماء إذا كان واعياً"
    ])
]

// MARK: - Glass style

extension View {
    func glass(radius: CGFloat = 24) -> some View {
        self
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: radius))
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: .darkGreen.opacity(0.1), radius: 15, y: 8)
    }
}

// MARK: - Screen

struct FirstAidView: View {
    @State private var selected: AidCase?

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            background

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("الإسعافات الأولية")
                        .font(.largeTitle.bold())
                        .foregroundColor(.darkGreen)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(aidCases) { item in
                            Button { selected = item } label: {
                                card(item)
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .sheet(item: $selected) { item in
            StepsView(item: item)
                .presentationDetents([.medium, .large])
                .presentationBackground(.ultraThinMaterial)
        }
    }

    var background: some View {
        ZStack {
            LinearGradient(colors: [.offWhite, .sand], startPoint: .top, endPoint: .bottom)
            Circle().fill(Color.grayGreen.opacity(0.4))
                .frame(width: 250).blur(radius: 60).offset(x: 130, y: -250)
            Circle().fill(Color.brown.opacity(0.3))
                .frame(width: 280).blur(radius: 70).offset(x: -140, y: 150)
        }
        .ignoresSafeArea()
    }

    func card(_ item: AidCase) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: item.icon)
                .font(.system(size: 30))
                .foregroundColor(.darkGreen)
            Spacer()
            Text(item.title)
                .font(.headline)
                .foregroundColor(.darkGreen)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
        .padding(16)
        .glass()
    }
}

// MARK: - Steps

struct StepsView: View {
    let item: AidCase

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: item.icon)
                    Text(item.title)
                }
                .font(.title2.bold())
                .foregroundColor(.darkGreen)

                VStack(alignment: .leading, spacing: 18) {
                    ForEach(item.steps.indices, id: \.self) { i in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(i + 1)")
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.darkGreen, in: Circle())
                            Text(item.steps[i])
                                .foregroundColor(.darkGreen)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .glass()
            }
            .padding(20)
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    FirstAidView()
}
