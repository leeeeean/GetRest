//
//  Withdrawal.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit
import RxCocoa
import RxSwift

final class Withdrawal: UIViewController {
    
    private lazy var leaveAppLabel: UILabel = {
        let label = UILabel()
        label.text = "쉬자를 떠날래요"
        label.font = .systemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var leaveAppCompleteLabel: UILabel = {
        let label = UILabel()
        label.text = "회원정보 확인 후 탈퇴가 완료됩니다"
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.darkGray)
        
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.baseGray)
        
        return label
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = account
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.baseGreen)
        
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .appColor(.baseGray)
        
        return label
    }()

    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력"
        textField.font = .systemFont(ofSize: 14.0)
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
        return textField
    }()
    
    private lazy var passwordCheckLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.lightGray)
        
        return view
    }()
    
    private lazy var withdrawalLabel1: UILabel = {
        let label = UILabel()
        label.text = "지금 회원 탈퇴를 하시면 쉬자서비스를 더이상 이용하실 수 없습니다."
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .appColor(.darkGray)
        
        return label
    }()
    
    private lazy var withdrawalLabel2: UILabel = {
        let label = UILabel()
        label.text = "또한 쉬자 서비스를 가입/사용 하면서 축적된 정보 및 기록은 모두\n삭제되며, 복구가 불가능 합니다."
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .appColor(.darkGray)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var withdrawalLabel3: UILabel = {
        let label = UILabel()
        label.text = "해당 아이디로 작성한 기록과 자기소개서 등을 영구 소멸되므로,\n미리 확인하시고 탈퇴를 진행하시기를 바랍니다."
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .appColor(.darkGray)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var withdrawalButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("떠날래요", for: .normal)
        button.customBackgroundButton(
            enabled: .appColor(.baseGreen),
            disabled: .appColor(.baseGray)
        )
        button.layer.cornerRadius = 4.0
        button.isEnabled = false
        
        return button
    }()
    
    let disposeBag = DisposeBag()
    let account: String = "getrest1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {
        withdrawalButton.rx.tap
            .bind(to: self.rx.withdrawalAlert)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        title = "회원탈퇴"
        navigationController?.navigationBar.topItem?.title = ""
        
        [
            leaveAppLabel,
            leaveAppCompleteLabel,
            idLabel,
            accountLabel,
            passwordLabel,
            passwordCheckTextField,
            passwordCheckLineView,
            withdrawalLabel1,
            withdrawalLabel2,
            withdrawalLabel3,
            withdrawalButton
        ].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 24.0
        let labelOffset: CGFloat = 12.0
        leaveAppLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        leaveAppCompleteLabel.snp.makeConstraints {
            $0.top.equalTo(leaveAppLabel.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalTo(leaveAppLabel)
        }
        idLabel.snp.makeConstraints {
            $0.top.equalTo(leaveAppCompleteLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(leaveAppCompleteLabel.snp.leading)
        }
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.top)
            $0.leading.equalToSuperview().inset(100.0)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(idLabel.snp.leading)
        }
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.top)
            $0.leading.equalTo(accountLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        passwordCheckLineView.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(passwordLabel.snp.trailing).offset(inset)
            $0.trailing.equalTo(passwordCheckTextField.snp.trailing)
        }
        withdrawalLabel1.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(passwordLabel.snp.leading)
        }
        withdrawalLabel2.snp.makeConstraints {
            $0.top.equalTo(withdrawalLabel1.snp.bottom).offset(labelOffset)
            $0.leading.equalTo(withdrawalLabel1.snp.leading)
        }
        withdrawalLabel3.snp.makeConstraints {
            $0.top.equalTo(withdrawalLabel2.snp.bottom).offset(labelOffset)
            $0.leading.equalTo(withdrawalLabel2.snp.leading)
        }
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40.0)
            $0.leading.trailing.equalToSuperview().inset(60.0)
            $0.height.equalTo(48.0)
        }
    }
}

extension Withdrawal {
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let password = passwordCheckTextField.text,
              !password.isEmpty else {
            withdrawalButton.isEnabled = false
            return
        }
        withdrawalButton.isEnabled = true
    }
}

extension Withdrawal: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension Reactive where Base: Withdrawal {
    var withdrawalAlert: Binder<Void> {
        return Binder(base) { base, void in
            let alertController = ConfirmCancleAlerViewController(
                            image: UIImage(named: "MyPageWithdrawal")!,
                            message: "정말 가실거에요?",
                            alertType: .confirmAndCancle) {
                                print("탈퇴")
                                let vc = UINavigationController(rootViewController: LoginViewController())
                                vc.modalPresentationStyle = .fullScreen
                                base.present(vc, animated: true)
                                // 탈퇴 통신
                            }
            alertController.modalPresentationStyle = .overFullScreen
            base.present(alertController, animated: true)
        }
    }
}
