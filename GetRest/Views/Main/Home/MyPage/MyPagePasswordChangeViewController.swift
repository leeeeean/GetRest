//
//  MyPagePasswordChangeViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/01.
//

import UIKit

final class MyPagePasswordChangeViewController: UIViewController {
    
    private lazy var passwordChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 비밀번호를 입력해 주세요"
        label.font = .systemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호(8~16자리)"
        textField.font = .systemFont(ofSize: 14.0)
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .password
        textField.isSecureTextEntry = true

        return textField
    }()
    
    private lazy var passwordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.lightGray)
        
        return view
    }()
    
    private lazy var newPasswordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 재입력"
        textField.font = .systemFont(ofSize: 14.0)
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var passwordCheckLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.lightGray)
        
        return view
    }()
    
    private lazy var passwordSettingLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호는 8~16 자의 영문, 숫자, 특수문자를 조합하여\n설정해 주세요."
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.darkGray)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var passwordChangeDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "안전한 계정 사용을 위해 비밀번호는 주기적으로 변경해 주세요."
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.darkGray)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var passwordChangeButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("바꿀래요", for: .normal)
        button.customBackgroundButton(
            enabled: .appColor(.baseGreen),
            disabled: .appColor(.baseGray)
        )
        button.layer.cornerRadius = 4.0
        button.isEnabled = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {
        
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        title = "비밀번호 재설정"
        navigationController?.navigationBar.topItem?.title = ""
        
        [
            passwordChangeLabel,
            newPasswordTextField,
            passwordLineView,
            newPasswordCheckTextField,
            passwordCheckLineView,
            passwordSettingLabel,
            passwordChangeDurationLabel,
            passwordChangeButton
        ].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 24.0
        passwordChangeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordChangeLabel.snp.bottom).offset(inset)
            $0.leading.trailing.equalToSuperview().inset(inset)
        }
        passwordLineView.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(5.0)
            $0.height.equalTo(1.0)
            $0.leading.trailing.equalTo(newPasswordTextField)
        }
        newPasswordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(inset)
            $0.leading.trailing.equalTo(newPasswordTextField)
        }
        passwordCheckLineView.snp.makeConstraints {
            $0.top.equalTo(newPasswordCheckTextField.snp.bottom).offset(5.0)
            $0.height.equalTo(1.0)
            $0.leading.trailing.equalTo(newPasswordCheckTextField)
        }
        passwordSettingLabel.snp.makeConstraints {
            $0.top.equalTo(newPasswordCheckTextField.snp.bottom).offset(inset)
            $0.leading.trailing.equalTo(newPasswordCheckTextField)
        }
        passwordChangeDurationLabel.snp.makeConstraints {
            $0.top.equalTo(passwordSettingLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.equalTo(newPasswordCheckTextField)
        }
        passwordChangeButton.snp.makeConstraints {
            $0.top.equalTo(passwordChangeDurationLabel.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(52.0)
            $0.height.equalTo(48.0)
        }
    }
}
