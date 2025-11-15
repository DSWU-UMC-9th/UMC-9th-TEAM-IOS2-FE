//
//  Fonts.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extrabold
        case bold
        case semibold
        case medium
        case regular
        case light

        var value: String {
            switch self {
            case .extrabold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-Semibold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }

    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }

    static var XxxlMedium: Font {
        .pretend(type: .medium, size: 24)
    }

    static var XxlMedium: Font {
        .pretend(type: .medium, size: 22)
    }

    static var XlSemiBold: Font {
        .pretend(type: .semibold, size: 20)
    }

    static var LSemiBold: Font {
        .pretend(type: .semibold, size: 18)
    }

    static var MBold: Font {
        .pretend(type: .bold, size: 16)
    }

    static var MRegular: Font {
        .pretend(type: .regular, size: 16)
    }

    static var SBold: Font {
        .pretend(type: .bold, size: 14)
    }

    static var SSemiBold: Font {
        .pretend(type: .semibold, size: 14)
    }

    static var SMedium: Font {
        .pretend(type: .medium, size: 14)
    }

    static var XsBold: Font {
        .pretend(type: .bold, size: 12)
    }

    static var XsMedium: Font {
        .pretend(type: .medium, size: 12)
    }

    static var XxsMedium: Font {
        .pretend(type: .medium, size: 10)
    }
}
