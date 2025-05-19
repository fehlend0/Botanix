import Foundation
import SwiftUI

extension Font {
    public static var vBodySmall: Font {
        Font.system(size: 18, weight: .medium, design: .default)
    }
    public static var vBodyMedium: Font {
        Font.system(size: 20, weight: .medium, design: .default)
    }
    public static var vBodyMediumBold: Font {
        Font.system(size: 20, weight: .bold, design: .default)
    }
    public static var vBodyLarge: Font {
        Font.custom("Arial",  size: 20)
    }
    public static var vHeadlineSmall: Font {
        Font.system(size: 24, weight: .bold, design: .default)
    }
    public static var vHeadlineMedium: Font {
        Font.system(size: 26, weight: .bold, design: .default)
    }
    public static var vHeadlineLarge: Font {
        Font.system(size: 60, weight: .bold, design: .default)
    }
    public static var vLabelSmall: Font {
        Font.custom("Arial",  size: 11)
    }
    public static var vLabelMedium: Font {
        Font.custom("Arial",  size: 12)
    }
    public static var vLabelLarge: Font {
        Font.system(size: 16, weight: .medium, design: .default)
    }
    public static var vLabelLargeBold: Font {
        Font.system(size: 16, weight: .bold, design: .default)
    }
}
