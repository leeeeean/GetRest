//
//  Color+.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/18.
//

import UIKit

enum AssetsColor {
    case baseGreen
    case lightGreen
    case darkGreen
    case baseGray
    case darkGray
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .baseGreen:
            return #colorLiteral(red: 0.5123510361, green: 0.7481395602, blue: 0.3497535586, alpha: 1)
        case .lightGreen:
            return #colorLiteral(red: 0.8844486475, green: 0.9361888766, blue: 0.8604691625, alpha: 1)
        case .darkGreen:
            return #colorLiteral(red: 0.3022342026, green: 0.5553817749, blue: 0.105690904, alpha: 1)
        case .baseGray:
            return #colorLiteral(red: 0.7803922892, green: 0.7803922296, blue: 0.7803922892, alpha: 1)
        case .darkGray:
            return #colorLiteral(red: 0.6078431606, green: 0.6078431606, blue: 0.6078432202, alpha: 1)
        }
    }
}
