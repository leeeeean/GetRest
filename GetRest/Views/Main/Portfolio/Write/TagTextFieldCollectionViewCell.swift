//
//  TagTextFieldCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/24.
//

import UIKit

final class TagTextFieldCollectionView: UICollectionViewCell {
    static let identifier = "TagTextFieldCollectionView"

    lazy var tagTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .appColor(.middleGreen)
        textField.textColor = .white
        textField.layer.cornerRadius = 12.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 1.0))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 1.0))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.text = "동아리"
        textField.font = .systemFont(ofSize: 16.0)
        textField.tintColor = .white
        textField.delegate = viewController
        
        return textField
    }()
    
    private let viewController = WriteViewController()
    
    func layout() {
        addSubview(tagTextField)
        tagTextField.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        })
    }
}
