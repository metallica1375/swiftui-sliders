import SwiftUI

public struct DefaultThumb: View {
    public init() {}
    public var body: some View {
        Capsule()
            .foregroundColor(Color(hex: "#FFC800"))
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1.5)
    }
}

public extension CGSize {
    static let defaultThumbSize: CGSize = CGSize(width: 27, height: 27)
    static let defaultThumbInteractiveSize : CGSize = CGSize(width: 44, height: 44)
}

struct DefaultThumb_Previews: PreviewProvider {
    static var previews: some View {
        DefaultThumb()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
