import SwiftUI
 
// MARK: - 1. DATA MODELS
 
// A sheet is built from blocks, drawn top to bottom.
enum ContentBlock: Hashable {
    case image(String, height: CGFloat = 180)   // Picture name + max height (180 if you don't give one).
    case paragraph(String)                      // Normal text.
    // A list of texts: every text is drawn as its own row, with the same icon.
    case instructions(icon: String, color: Color, size: CGFloat, texts: [String])
}
 
// One InfoSection = one button inside a disaster page.
//   - if it has "blocks"      -> it opens a bottom SHEET with that content
//   - if it has "subSections" -> it opens a new PAGE that contains more buttons
struct InfoSection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String       // SF Symbol name.
    let color: Color       // Icon color.
    var blocks: [ContentBlock] = []             // "= []" means "empty by default".
    var subSections: [InfoSection] = []
}
 
// One Disaster = one card on the home screen + one full page behind it.
struct Disaster: Identifiable, Hashable {
    let id = UUID()
    let title: String           // Card title AND the banner title on the disaster's page.
    let cardSubtitle: String    // The text under the title on the card.
    let cardImage: String       // Picture on the card (name in Assets).
    let bannerText: String      // Short description inside the banner of the disaster's page.
    let bannerImage: String     // Picture inside that banner (name in Assets).
    let sections: [InfoSection] // The buttons of the disaster's page.
}
 
// MARK: - 2. THE REUSABLE DISASTER PAGE
struct DisasterPage: View {
    let disaster: Disaster   // The disaster whose page we are showing.
 
    @State private var selectedSection: InfoSection?   // Which sheet is open (nil = none).
 
    var body: some View {
        ZStack {
            BackgroundView()
 
            ScrollView {
                VStack(spacing: 20) {
 
                    DisasterBanner(disaster: disaster)
                        .padding(.bottom, 26)
 
                    ForEach(disaster.sections) { section in
                        SectionRow(section: section) {
                            selectedSection = section   // Only used by buttons that open a sheet.
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 120)   // Room so the home button never covers a button.
            }
        }
        .customBackButton()
        .sheet(item: $selectedSection) { section in
            SectionSheet(section: section)
        }
    }
}
 
// MARK: - 3. SUB PAGE (a page that only has buttons)
struct SubSectionsPage: View {
    let section: InfoSection   // The button that was tapped on the previous page.
 
    @State private var selectedSection: InfoSection?
 
    var body: some View {
        ZStack {
            BackgroundView()
 
            ScrollView {
                VStack(spacing: 16) {
 
                    HStack(spacing: 12) {
                        Image(systemName: section.icon)
                            .font(.system(size: 32))
                            .foregroundStyle(section.color)
                        Text(section.title)
                            .font(.app(26, bold: true))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 24)
 
                    ForEach(section.subSections) { sub in
                        SectionRow(section: sub) {
                            selectedSection = sub
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 120)
            }
        }
        .customBackButton()
        .sheet(item: $selectedSection) { sub in
            SectionSheet(section: sub)
        }
    }
}
 
// MARK: - 4. BANNER OF THE DISASTER PAGE
struct DisasterBanner: View {
    let disaster: Disaster
 
    var body: some View {
        HStack(spacing: 16) {   // In RTL the first item is on the right.
 
            VStack(alignment: .leading, spacing: 6) {
                Text(disaster.title)
                    .font(.app(26, bold: true))
                Text(disaster.bannerText)
                    .font(.app(14))
                    .lineSpacing(4)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
 
            Color.white.opacity(0.15)
                .frame(width: 140, height: 120)
                .overlay {
                    Image(disaster.bannerImage)
                        .resizable()
                        .scaledToFill()
                }
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(AppColors.banner)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
 
// MARK: - 5. THE BUTTON
//   SectionRowLabel = only HOW the button LOOKS.
//   SectionRow      = decides WHAT HAPPENS when it is tapped (open a sheet, or go to a page).
 
struct SectionRowLabel: View {
    let section: InfoSection
 
    var body: some View {
        HStack(spacing: 16) {
 
            Image(systemName: section.icon)
                .font(.system(size: 24))
                .foregroundStyle(section.color)
                .frame(width: 26)
 
            Text(section.title)
                .font(.app(20, bold: true))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
 
            Spacer(minLength: 8)
 
            Image(systemName: "chevron.forward")   // Flips to point left in RTL.
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black.opacity(0.3))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, minHeight: 78)
        .background(AppColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: 20))
    }
}
 
struct SectionRow: View {
    let section: InfoSection
    let onOpenSheet: () -> Void   // The action to run if this button opens a sheet.
 
    var body: some View {
        if section.subSections.isEmpty {
            // No sub-sections: a normal button that opens a sheet.
            Button(action: onOpenSheet) {
                SectionRowLabel(section: section)
            }
            .buttonStyle(.plain)
        } else {
            // It has sub-sections: a link that pushes a new page (the router is in MainScreen).
            NavigationLink(value: section) {
                SectionRowLabel(section: section)
            }
            .buttonStyle(.plain)
        }
    }
}
 
// MARK: - 6. THE SHEET (opens from the bottom, scrolls up and down)
struct SectionSheet: View {
    let section: InfoSection
 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
 
                HStack(spacing: 14) {
                    Image(systemName: section.icon)
                        .font(.system(size: 24))
                        .foregroundStyle(section.color)
                    Text(section.title)
                        .font(.app(26, bold: true))
                        .foregroundStyle(.black)
                }
 
                // Draws every block of the section, in order.
                ForEach(section.blocks.indices, id: \.self) { index in
                    switch section.blocks[index] {
 
                    case .paragraph(let text):
                        Text(text)
                            .font(.app(16))
                            .foregroundStyle(.black.opacity(0.8))
                            .lineSpacing(6)
                            .multilineTextAlignment(.leading)
 
                    case .instructions(let icon, let color, let size, let texts):
                        VStack(alignment: .leading, spacing: 30) {          // Gap between instructions.
                            ForEach(texts.indices, id: \.self) { i in       // One row per text.
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: icon)
                                        .font(.system(size: size))
                                        .foregroundStyle(color)
                                    Text(texts[i])
                                        .font(.app(20))
                                        .foregroundStyle(.black.opacity(0.8))
                                        .lineSpacing(6)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
 
                    case .image(let name, let height):
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: height)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
            .padding(.top, 12)
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationBackground(AppColors.background)
        .environment(\.layoutDirection, .rightToLeft)
        .preferredColorScheme(.light)
    }
}
 
#Preview {
    Text("صفحة الكوارث")
}
