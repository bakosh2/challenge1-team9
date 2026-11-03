import SwiftUI

extension Disaster {
    static let naturalDisasters = Disaster(
        title: "الكوارث الطبيعية",
        cardSubtitle: "تعرّف على المخاطر البيئية وطرق الوقاية",
        cardImage: "Extreme1",
        bannerText: "تعرّف على المخاطر البيئية\nوتعلّم طرق الوقاية.",
        bannerImage: "Extreme1",
        sections: [
            InfoSection(
                title: "العواصف الرملية",
                icon: "wind",
                color: AppIconColor.iconOlive,
                blocks: [
                    .image("Sand", height: 180),
                    .instructions(
                        icon: "checkmark.circle",
                        color: AppIconColor.iconOlive,
                        size: 20,
                        texts: [
                            "ابقَ في مكان آمن وأغلق النوافذ والأبواب.",
                            "تجنب القيادة أثناء انعدام الرؤية.",
                            "ارتدِ كمامة أو غطِّ الأنف والفم عند الحاجة."
                        ]
                    )
                ]
            ),
            InfoSection(
                title: "الأمطار والسيول",
                icon: "cloud.heavyrain",
                color: AppIconColor.iconOlive,
                blocks: [
                    .image("flood1", height: 180),
                    .instructions(
                        icon: "checkmark.circle",
                        color: AppIconColor.iconOlive,
                        size: 20,
                        texts: [
                            "ابتعد عن مجاري السيول والمنخفضات.",
                            "لا تعبر المياه الجارية سيرًا أو بالسيارة.",
                            "اتبع تنبيهات الجهات الرسمية."
                        ]
                    )
                ]
            ),
            InfoSection(
                title: "العواصف الرعدية",
                icon: "cloud.bolt",
                color: AppIconColor.iconOlive,
                blocks: [
                    .image("Storm1", height: 180),
                    .instructions(
                        icon: "checkmark.circle",
                        color: AppIconColor.iconOlive,
                        size: 20,
                        texts: [
                            "احتمِ داخل مبنى وأغلق الأجهزة الكهربائية.",
                            "ابتعد عن الأشجار والأعمدة والأماكن المكشوفة.",
                            "لا تستخدم الهاتف أو الأجهزة المتصلة أثناء البرق."
                        ]
                    )
                ]
            ),
            InfoSection(
                title: "الحرارة الشديدة",
                icon: "sun.max",
                color: AppIconColor.iconOlive,
                blocks: [
                    .image("Extreme1", height: 180),
                    .instructions(
                        icon: "checkmark.circle",
                        color: AppIconColor.iconOlive,
                        size: 20,
                        texts: [
                            "اشرب الماء بانتظام وتجنب التعرض للشمس وقت الظهيرة.",
                            "ارتدِ ملابس فاتحة وخفيفة.",
                            "اطلب المساعدة عند الشعور بالدوار أو الإجهاد."
                        ]
                    )
                ]
            ),
            InfoSection(
                title: "البرد الشديد",
                icon: "thermometer.snowflake",
                color: AppIconColor.iconOlive,
                blocks: [
                    .image("cold", height: 180),
                    .instructions(
                        icon: "checkmark.circle",
                        color: AppIconColor.iconOlive,
                        size: 20,
                        texts: [
                            "حافظ على دفء الجسم وارتدِ عدة طبقات من الملابس.",
                            "تجنب البقاء في الأماكن المكشوفة لفترات طويلة.",
                            "راقب علامات انخفاض حرارة الجسم واطلب المساعدة."
                        ]
                    )
                ]
            )
        ]
    )
}
