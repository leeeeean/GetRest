//
//  CustomButton.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/18.
//

import UIKit

class CustomButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? enabledColor : disabledColor
        }
    }
    private var enabledColor: UIColor = .clear
    private var disabledColor: UIColor = .clear

    func customBackgroundButton(enabled: UIColor, disabled: UIColor) {
        self.enabledColor = enabled
        self.disabledColor = disabled
    }
}
