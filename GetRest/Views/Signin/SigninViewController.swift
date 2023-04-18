//
//  SigninViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/18.
//

import UIKit
import RxCocoa
import RxSwift

final class SigninViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.tintColor = .label
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .medium)
        textField.attributedPlaceholder = NSAttributedString(
            string: "홍길동",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.borderStyle = .line
        textField.layer.cornerRadius = 3.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [nameLabel, nameTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.tintColor = .label
        
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .medium)
        textField.attributedPlaceholder = NSAttributedString(
            string: "ID",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.borderStyle = .line
        textField.layer.cornerRadius = 3.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    
        return textField
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [idLabel, idTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.tintColor = .label
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .medium)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.borderStyle = .line
        textField.layer.cornerRadius = 3.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [passwordLabel, passwordTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var checkPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.tintColor = .label
        
        return label
    }()
    
    private lazy var notSameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "*비밀번호가 서로 맞지 않아요 ㅜ△ㅜ"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.tintColor = .red
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [checkPasswordLabel, notSameErrorLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()

    private lazy var checkPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .medium)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Check Password",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.borderStyle = .line
        textField.layer.cornerRadius = 3.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    
        return textField
    }()
    
    private lazy var checkPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [labelStackView, checkPasswordTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var labelTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24.0
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        [
            nameStackView,
            idStackView,
            passwordStackView,
            checkPasswordStackView
        ]
            .forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    
    private lazy var signinButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("다썼어요", for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .appColor(.baseGreen)
        button.layer.cornerRadius = 3.0
        
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
//        guard let id = idTextField.text,
//              let password = passworTextField.text,
//              !id.isEmpty,
//              !password.isEmpty
//        else {
//            loginButton.isEnabled = false
//            return
//        }
//
//        loginButton.isEnabled = true
    }
    
    private func layout() {
        
    }
    
}
