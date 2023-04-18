//
//  LoginViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lightbulb")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(
            string: "ID",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16.0, weight: .light),
                .foregroundColor: UIColor.appColor(.baseGreen)
            ])
        textField.textColor = .label
        textField.layer.cornerRadius = 3.0
        textField.backgroundColor = .appColor(.lightGreen)
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
        return textField
    }()
    
    private lazy var passworTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(
            string: "PASSWORD",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16.0, weight: .light),
                .foregroundColor: UIColor.appColor(.baseGreen)
            ])
        textField.textColor = .label
        textField.layer.cornerRadius = 3.0
        textField.backgroundColor = .appColor(.lightGreen)
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
        return textField
    }()
    
    lazy var autoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .appColor(.darkGreen)
        button.tag = 0
        return button
    }()
    
    private lazy var autoLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "자동로그인"
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.tintColor = .white
        return label
    }()
    
    private lazy var signinLabel: UILabel = {
        let label = UILabel()
        label.text = "처음이라구요?"
        label.font = .systemFont(ofSize: 13.0, weight: .light)
        label.tintColor = .white
        return label
    }()
    
    private lazy var signinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.titleLabel?.textColor = .white
        return button
    }()

    private lazy var autoLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        [autoLoginButton, autoLoginLabel]
            .forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(10.0, after: autoLoginButton)
        
        return stackView
    }()
    
    private lazy var signinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        [signinLabel, signinButton]
            .forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(16.0, after: signinLabel)
        
        return stackView
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("들어갈래요", for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.backgroundColor = .appColor(.darkGreen)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = UIColor(ciColor: .black).cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 3.0
        
        button.isEnabled = false
        return button
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel(model: LoginModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind(viewModel: viewModel)
    }
    
    func bind(viewModel: LoginViewModel) {
//        자동로그인 버튼이 탭 됐을 때
//        로그인 될 때 tag 정보가 넘어가야 합니다 (loginButton.rx.tap)
        autoLoginButton.rx.tap
            .map {
                (
                    self.autoLoginButton.tag == 0 ?
                    UIImage(systemName: "checkmark.circle.fill") :
                    UIImage(systemName: "checkmark.circle")
                ) ?? UIImage()
            }
            .bind(to: self.rx.toggleButton)
            .disposed(by: disposeBag)
        
//        회원 가입 버튼이 탭 되었을 떄
        signinButton.rx.tap
            .bind(to: self.rx.moveToSigninView)
            .disposed(by: disposeBag)
        
//        아이디 비밀번호가 모두 채워졌을 때 들어갑니다 활성화
//        아이디 비밀번호가 맞는지 확인해야 합니다
        loginButton.rx.tap
            .bind(to: self.rx.moveToMainView)
            .disposed(by: disposeBag)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let id = idTextField.text,
              let password = passworTextField.text,
              !id.isEmpty,
              !password.isEmpty
        else {
            loginButton.isEnabled = false
            return
        }
        
        loginButton.isEnabled = true
    }
    
    private func layout() {
        [
            imageView,
            idTextField,
            passworTextField,
            autoLoginStackView,
            signinStackView,
            loginButton
        ]
            .forEach({ view.addSubview($0) })

        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200.0)
            $0.height.equalTo(imageView.snp.width)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(32.0)
            $0.leading.trailing.equalToSuperview().inset(32.0)
            $0.height.equalTo(32.0)
        }

        passworTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(32.0)
            $0.height.equalTo(idTextField.snp.height)
        }

        autoLoginStackView.snp.makeConstraints {
            $0.top.equalTo(passworTextField.snp.bottom).offset(16.0)
            $0.leading.equalTo(passworTextField.snp.leading)
            $0.height.equalTo(20.0)
        }
        
        signinStackView.snp.makeConstraints {
            $0.top.equalTo(passworTextField.snp.bottom).offset(16.0)
            $0.trailing.equalTo(passworTextField.snp.trailing)
            $0.height.equalTo(20.0)

        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(signinStackView.snp.bottom).offset(24.0)
            $0.leading.equalTo(autoLoginStackView.snp.leading)
            $0.trailing.equalTo(signinStackView.snp.trailing)
            $0.height.equalTo(48.0)
        }

        view.backgroundColor = .appColor(.baseGreen)
    }
}

extension Reactive where Base: LoginViewController {
    var toggleButton: Binder<UIImage> {
        return Binder(base) { base, image in
            base.autoLoginButton.setImage(image, for: .normal)
            base.autoLoginButton.tag = base.autoLoginButton.tag == 0 ? 1 : 0
        }
    }
    
    var moveToSigninView: Binder<Void> {
        return Binder(base) { base, void in
            let viewController = SigninViewController()
            base.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    var moveToMainView: Binder<Void> {
        return Binder(base) { base, void in
            let viewController = MainViewController()
            base.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}