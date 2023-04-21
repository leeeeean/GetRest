//
//  UILabel+.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit

extension UILabel {
    func attributeFontColor(target: String, font: UIFont, color: UIColor) {
        let text = text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: target)
        attributedString.addAttributes([
            .font: font,
            .foregroundColor: color
        ], range: range)
        self.attributedText = attributedString
    }
}
