//
//  ConfirmCancleAlerViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/19.
//

import UIKit
import RxCocoa
import RxSwift

enum AlertType {
    case onlyConfirm
    case confirmAndCancle
}

final class ConfirmCancleAlerViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height
        ))
        view.backgroundColor = .gray
        view.layer.opacity = 0.5
        
        return view
    }()
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()
    
    private lazy var alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        guard let image = image else {
            imageView.isHidden = true
            return imageView
        }
        imageView.image = image
        imageView.isHidden = false
        
        return imageView
    }()
    
    private lazy var alertMessageLabel: UILabel = {
        let label = UILabel()
        
        guard let text = message else {
            label.isHidden = true
            return label
        }
        label.text = text
        label.isHidden = false
        
        return label
    }()
    
    private lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니오", for: .normal)
        button.backgroundColor = .appColor(.baseGray)
        guard alertType == .onlyConfirm else {
            button.isHidden = false
            return button
        }
        button.isHidden = true
        
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("네", for: .normal)
        button.backgroundColor = .appColor(.baseGreen)

        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        [cancleButton, confirmButton].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    let disposeBag = DisposeBag()
    
    let image: UIImage?
    let message: String?
    let alertType: AlertType
    let completion: () -> ()
    
    init(image: UIImage? = nil, message: String, alertType: AlertType, completion: @escaping () -> Void) {
        self.image = image
        self.message = message
        self.alertType = alertType
        self.completion = completion
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(image: UIImage, message: String, alertType: AlertType, completion: @escaping () -> Void) {
        self.image = image
        self.message = message
        self.alertType = alertType
        self.completion = completion

        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    let signin = SigninViewController()
    func bind() {
        confirmButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.confirmButtonTapped(state: true)
            })
            .disposed(by: disposeBag)
        
        cancleButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.cancleButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    func cancleButtonTapped() {
        dismiss(animated: true)
    }
    
    func confirmButtonTapped(state: Bool) {
        dismiss(animated: true)
        completion()
    }
    
    private func layout() {
        view.backgroundColor = .clear
        
        [backgroundView, alertView, alertImageView, alertMessageLabel, buttonStackView]
            .forEach { view.addSubview($0) }
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalTo(backgroundView.snp.center)
            $0.width.equalTo(250.0)
            guard let _ = image,
                  let _ = message else {
                $0.height.equalTo(150.0)
                return
            }
            $0.height.equalTo(250.0)
        }
        
        alertImageView.snp.makeConstraints {
            $0.top.equalTo(alertView.snp.top)
            $0.leading.equalTo(alertView.snp.leading)
            $0.trailing.equalTo(alertView.snp.trailing)
            if image == nil { $0.height.equalTo(0.0) }
            else { $0.height.equalTo(150.0) }
        }
        
        alertMessageLabel.snp.makeConstraints {
            $0.top.equalTo(alertImageView.snp.bottom)
            $0.centerX.equalTo(alertImageView.snp.centerX)
            if message == nil { $0.height.equalTo(0.0) }
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(alertMessageLabel.snp.bottom)
            $0.leading.equalTo(alertImageView.snp.leading)
            $0.trailing.equalTo(alertImageView.snp.trailing)
            $0.bottom.equalTo(alertView.snp.bottom)
            $0.height.equalTo(50.0)
        }
    }
}


