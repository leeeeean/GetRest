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
        setLabel("이름", label: label)
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        setTextField("홍길동", textField: textField)

        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        setStackView(.vertical, stackView: stackView)
        
        [nameLabel, nameTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        setLabel("아이디", label: label)
        
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        setTextField("ID", textField: textField)
    
        return textField
    }()
    
    private lazy var idStackView: UIStackView = {
        let stackView = UIStackView()
        setStackView(.vertical, stackView: stackView)
        
        [idLabel, idTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        setLabel("비밀번호", label: label)
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setTextField("Password", textField: textField)
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword
        // ios keychain 적용할 수 있도록 나중에 바꿔보기
        
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        setStackView(.vertical, stackView: stackView)
        
        [passwordLabel, passwordTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var checkPasswordLabel: UILabel = {
        let label = UILabel()
        setLabel("비밀번호 확인", label: label)

        return label
    }()
    
    private lazy var notSameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "*비밀번호가 서로 맞지 않아요 ㅜ△ㅜ"
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.textColor = .appColor(.darkRed)
        label.isHidden = true
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fill
        
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 1))
        
        [checkPasswordLabel, notSameErrorLabel, spacer].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(8.0, after: checkPasswordLabel)

        return stackView
    }()

    private lazy var checkPasswordTextField: UITextField = {
        let textField = UITextField()
        setTextField("Check Password", textField: textField)
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword
        
        return textField
    }()
    
    private lazy var checkPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        setStackView(.vertical, stackView: stackView)
        stackView.spacing = 16.0
        stackView.alignment = .fill
        
        [labelStackView, checkPasswordTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    
    private lazy var signinButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("다썼어요", for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .appColor(.baseGreen)
        button.layer.cornerRadius = 5.0
        
        button.isEnabled = false
        return button
    }()
    
    private func setLabel(_ text: String, label: UILabel) {
        label.text = text
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.textColor = .label
    }
    
    private func setTextField(_ placeholder: String, textField: UITextField) {
        textField.font = .systemFont(ofSize: 16.0, weight: .light)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.layer.borderWidth = 0.7
        textField.layer.cornerRadius = 5.0
        textField.layer.borderColor = UIColor.appColor(.baseGray).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 50.0))
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        textField.addTarget(self, action: #selector(checkPasswordIsSame), for: .allEditingEvents)
    }
    
    private func setStackView(_ axix: NSLayoutConstraint.Axis, stackView: UIStackView) {
        stackView.axis = axix
        stackView.spacing = 8.0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {
        // 다썻어요 클릭시 - 팝업
        signinButton.rx.tap
//            .bind(to: )
//            .disposed(by: disposeBag)
        
        // 회원가입 데이터 입력
        // MainViewController 진입
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let id = idTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text,
              let checkPassword = checkPasswordTextField.text,
              !id.isEmpty,
              !password.isEmpty,
              !name.isEmpty,
              !checkPassword.isEmpty
        else {
            signinButton.isEnabled = false
            return
        }
        signinButton.isEnabled = true
    }
    
    @objc func checkPasswordIsSame(_ textField: UITextField) {
        guard let password = passwordTextField.text,
              let checkPassword = checkPasswordTextField.text,
              password == checkPassword
        else {
            notSameErrorLabel.isHidden = false
            return
        }
        notSameErrorLabel.isHidden = true
    }
    private func colorToImage(_ color: UIColor) -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 10)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
    private func layout() {
        title = "회원가입"
        
        navigationController?.navigationBar.tintColor = .appColor(.baseGreen)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.baseGreen).cgColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0, weight: .medium)
        ]
        // navigation bar 아래에 그림자를 만드는 법! -> backgroundColor을 넣어주고 shadow 설정
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.2
        navigationController?.navigationBar.layer.masksToBounds = false
        
        view.backgroundColor = .systemBackground
        
        [
            nameStackView,
            idStackView,
            passwordStackView,
            checkPasswordStackView,
            signinButton
        ].forEach { view.addSubview($0) }
        
        let insetWithStack: CGFloat = 32.0
        let insetWithLabelTextField: CGFloat = 28.0
        let stackHeight: CGFloat = 100.0
        
        nameStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(insetWithStack)
            $0.leading.trailing.equalToSuperview().inset(insetWithLabelTextField)
            $0.height.equalTo(stackHeight)
        }
        
        idStackView.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(insetWithStack)
            $0.leading.equalTo(nameStackView.snp.leading)
            $0.trailing.equalTo(nameStackView.snp.trailing)
            $0.height.equalTo(stackHeight)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(idStackView.snp.bottom).offset(insetWithStack)
            $0.leading.equalTo(idStackView.snp.leading)
            $0.trailing.equalTo(idStackView.snp.trailing)
            $0.height.equalTo(stackHeight)
        }
        
        checkPasswordStackView.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom).offset(insetWithStack)
            $0.leading.equalTo(passwordStackView.snp.leading)
            $0.trailing.equalTo(passwordStackView.snp.trailing)
            $0.height.equalTo(stackHeight)
        }
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(checkPasswordStackView.snp.bottom).offset(48.0)
            $0.leading.trailing.equalToSuperview().inset(56.0)
            $0.height.equalTo(48.0)
        }
    }
    
}
