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
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
}
