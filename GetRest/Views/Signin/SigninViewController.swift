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
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SigninBackground")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        setLabel("이름", label: label)
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        setTextField("한들 또는 영문으로 씁시다", textField: textField)

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
        setTextField("아이디", textField: textField)
    
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
        setTextField("영어 + 숫자 6자 이상", textField: textField)
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
        setTextField("한번 더 확인해봐요", textField: textField)
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
        button.setTitleColor(.white, for: .disabled)
        button.titleLabel?.textColor = .white
        button.customBackgroundButton(
            enabled: UIColor.appColor(.baseGreen),
            disabled: UIColor.appColor(.baseGray)
        )
        button.layer.cornerRadius = 5.0
        
        button.isEnabled = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.overrideUserInterfaceStyle = .light
        
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var keyboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private func setLabel(_ text: String, label: UILabel) {
        label.text = text
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.textColor = .black
    }
    
    private func setTextField(_ placeholder: String, textField: UITextField) {
        textField.delegate = self
        
        textField.font = .systemFont(ofSize: 16.0, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .light),
                NSAttributedString.Key.foregroundColor : UIColor.appColor(.darkGray)
            ])
        textField.textColor = .appColor(.baseGreen)
        textField.layer.borderWidth = 0.7
        textField.layer.cornerRadius = 5.0
        textField.layer.borderColor = UIColor.appColor(.darkGray).cgColor
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
    let viewModel = SigninViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind(viewModel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func bind(_ viewModel: SigninViewModel) {
        // 다썻어요 클릭시 - 팝업
        signinButton.rx.tap
            .bind(to: self.rx.confirmAlert)
            .disposed(by: disposeBag)
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
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.size.height = 1100
        }
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        view.frame.size.height =  view.safeAreaLayoutGuide.layoutFrame.height - 100
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
        
        navigationController?.navigationBar.barTintColor = .white
        
        view.backgroundColor = .systemBackground
        
        let insetWithStack: CGFloat = 32.0
        let insetWithLabelTextField: CGFloat = 28.0
        let stackHeight: CGFloat = 100.0


        view.frame.size.height = view.safeAreaLayoutGuide.layoutFrame.height-100

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height)
        }

        [backgroundImageView, nameStackView, idStackView, passwordStackView, checkPasswordStackView, signinButton]
            .forEach { backgroundView.addSubview($0) }

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }

        nameStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(insetWithStack)
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

extension SigninViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension Reactive where Base: SigninViewController {
    var confirmAlert: Binder<Void> {
        return Binder(base) { base, void in
/*
            해결 1
            let alertController = ConfirmCancleAlerViewController(
                image: UIImage(systemName: "circle")!,
                message: "회원가입이 완료되었어요",
                alertType: .onlyConfirm
            )
            alertController.modalPresentationStyle = .fullScreen
            base.present(alertController, animated: true)
            
            해결 2
            let alertController = UIAlertController(title: "회원가입이 완료되었어요", message: nil, preferredStyle: .alert)
            let confirmActionButton = UIAlertAction(title: "확인", style: .default) { _ in
                print("회원가입")
                // MainViewController 진입
                let viewController = MainViewController()
                viewController.modalPresentationStyle = .fullScreen
                base.present(viewController, animated: true)
            }

            alertController.addAction(confirmActionButton)
            base.present(alertController, animated: true)
*/
//            해결 3
            let alertController = ConfirmCancleAlerViewController(
                            image: UIImage(named: "SigninAlert")!,
                            message: "회원가입이 완료되었어요",
                            alertType: .onlyConfirm) {
                                print("회원가입")
                                let vc = MainTabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                base.present(vc, animated: true)
                            }
            alertController.modalPresentationStyle = .overFullScreen
            base.present(alertController, animated: true)
        }
    }
}

/*
 문제 : 모달 UIViewController에서 실시간 데이터 이동이 안됨
 해결1 > fullScreen으로하고 viewWillAppear 사용
        modalPresentationStyle의 상태를 무조건 fullScreen으로 해야만 viewWillAppear가 동작
        투명하게 비치는 alert를 만들어야함 --> .overFullScreen --> viewWillAppear 동작 X
 해결2 > 기본 alertController 사용..
 해결3 > confirm을 누르면 해야할 일은 completion 값에 넘겨본다... 이게 맞는지는 모르겠는....
 */
