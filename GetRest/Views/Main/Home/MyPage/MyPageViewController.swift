//
//  MyPageViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/01.
//

import UIKit

final class MyPageViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MyPageBackground")
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "\(name)님\n오늘도 화이팅이에요!"
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.textColor = .white
        label.attributeFontColor(
            target: name,
            font: .systemFont(ofSize: 24, weight: .bold),
            color: .white
        )
        
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "MyPageLogoutButton"), for: .normal)
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보"
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.textColor = .appColor(.darkGray)
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = name
        textField.font = .systemFont(ofSize: 20.0, weight: .light)
        textField.tintColor = .appColor(.baseGreen)
        
        return textField
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.baseGreen)
        
        return view
    }()
    
    private lazy var accountSecurityLabel: UILabel = {
        let label = UILabel()
        label.text = "계정보안"
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.textColor = .appColor(.darkGray)
        
        return label
    }()
    
    private lazy var accountIDLabel: UILabel = {
        let label = UILabel()
        label.text = accountID
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.textColor = .appColor(.baseGreen)
        
        return label
    }()
    
    private lazy var passwordChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 비밀번호 변경"
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .appColor(.darkGray)
        
        return label
    }()
    
    private lazy var passwordChangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RightAngleBracket"), for: .normal)
        button.addTarget(self, action: #selector(passwordChangeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    var name: String
    var accountID: String
    init(name: String, accountID: String) {
        self.name = name
        self.accountID = accountID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "마이페이지"
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        let saveBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"),
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        let settingBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(settingButtonTapped)
        )
        navigationItem.rightBarButtonItems = [settingBarButtonItem, saveBarButtonItem]
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .appColor(.baseGreen)
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        [
            backgroundImageView,
            logoutButton,
            privacyLabel,
            nameLabel,
            nameTextField,
            lineView,
            accountSecurityLabel,
            idLabel,
            accountIDLabel,
            passwordChangeLabel,
            passwordChangeButton
        ]
            .forEach{ view.addSubview($0) }
        
        backgroundImageView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(52.0)
            $0.leading.equalToSuperview().inset(120.0)
        }
        
        let inset: CGFloat = 20.0
        let imageHeight = backgroundImageView.image?.size.height
        let imageWidth = backgroundImageView.image?.size.width
        let width = UIScreen.main.bounds.size.width
        let height = imageHeight! * width / imageWidth!
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
        logoutButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(backgroundImageView.snp.bottom).offset(-16.0)
        }
        privacyLabel.snp.makeConstraints{
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(32.0)
            $0.leading.equalToSuperview().inset(inset)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(privacyLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(privacyLabel.snp.leading)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        lineView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(5.0)
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(1.0)
        }
        accountSecurityLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(32.0)
            $0.leading.equalTo(lineView.snp.leading)
        }
        idLabel.snp.makeConstraints {
            $0.top.equalTo(accountSecurityLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(accountSecurityLabel.snp.leading)
        }
        accountIDLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        passwordChangeLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(idLabel.snp.leading)
        }
        passwordChangeButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordChangeLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(inset)
        }
    }
}

extension MyPageViewController {
    @objc func saveButtonTapped() {
        // 유저 데이터 저장
        // userdefaults에 데이터 저장
        
        // label text 변경
        if let nameText = nameTextField.text,
           nameText != "" { name = nameText }
        else { nameTextField.text = name }
        nameTextField.resignFirstResponder()
        titlelabel.text = "\(name)님\n오늘도 화이팅이에요!"
        titlelabel.attributeFontColor(
            target: name,
            font: .systemFont(ofSize: 24, weight: .bold),
            color: .white
        )
    }
    
    @objc func settingButtonTapped() {
        let vc = MyPageSettingViewController(version: "(현재버전 1.0.0)")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutButtonTapped() {
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @objc func passwordChangeButtonTapped() {
        let vc = MyPagePasswordChangeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
