//
//  WriteViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit

final class WriteViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .appColor(.baseGray)
        imageView.image = UIImage(named: "")
        
        return imageView
    }()
    
    private lazy var writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .appColor(.baseGreen)
        label.text = "제목"
        
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0)
        textField.textColor = .label
        textField.text = "솝트"
        textField.placeholder = "입력하세요"
        
        return textField
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .fill,
            distribution: .equalCentering
        )
        
        return stackView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .appColor(.baseGreen)
        label.text = "카테고리"
        
        return label
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        button.titleLabel?.textColor = .label
        button.setTitle("항목", for: .normal)
        
        return button
    }()
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .fill,
            distribution: .equalCentering
        )
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .appColor(.baseGreen)
        label.text = "기간"
        
        return label
    }()
    
    private lazy var dateTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        button.titleLabel?.textColor = .label
        button.setTitle("YYYY.MM.DD ~ YYYY.MM.DD", for: .normal)
        
        return button
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .fill,
            distribution: .equalCentering
        )
        
        return stackView
    }()
    
    private lazy var titleCategoryDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .vertical,
            spacing: 16.0,
            alignment: .fill,
            distribution: .equalCentering
        )
        
        return stackView
    }()
    
    private func stackViewSetting(
        stackView: UIStackView,
        axis: NSLayoutConstraint.Axis,
        spacing: Double,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution
    ) {
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
    }
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TagTextFieldCollectionView.self, forCellWithReuseIdentifier: TagTextFieldCollectionView.identifier)
        collectionView.register(TagButtonCollectionViewCell.self, forCellWithReuseIdentifier: TagButtonCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.baseGray)
        
        return view
    }()
    
    private lazy var writeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "자기소개서를 작성해보세요"
        textView.delegate = self
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.down"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.title = "기록작성"
        navigationController?.navigationBar.tintColor = .appColor(.baseGreen)
        
        [backgroundImageView, writeView]
            .forEach({ view.addSubview($0) })
        
        backgroundImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(240.0)
        }
        writeView.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.top).inset(220.0)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        [
            titleCategoryDateStackView,
            tagCollectionView,
            lineView,
            writeTextView
        ].forEach({ writeView.addSubview($0) })
        
        titleCategoryDateStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.0)
            $0.trailing.leading.equalToSuperview().inset(20.0)
            $0.height.equalTo(100.0)
        }
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleCategoryDateStackView.snp.bottom).offset(10.0)
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
        }
        lineView.snp.makeConstraints {
            $0.height.equalTo(10.0)
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
        }
        writeTextView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(lineView.snp.bottom)
        }
        
        [titleLabel, titleTextField]
            .forEach({ titleStackView.addArrangedSubview($0) })
        [categoryLabel, categoryButton]
            .forEach({ categoryStackView.addArrangedSubview($0) })
        [dateLabel, dateTextButton]
            .forEach({ dateStackView.addArrangedSubview($0) })
        [titleStackView, categoryStackView, dateStackView]
            .forEach({ titleCategoryDateStackView.addArrangedSubview($0) })
        
    }
}

extension WriteViewController {
    @objc func saveButtonTapped() {
        
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.hasText else {
            textView.textColor = .appColor(.baseGray)
            textView.text = "입력해주세요"
            return
        }
    }
}

extension WriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagTextFieldCollectionView.identifier, for: indexPath) as? TagTextFieldCollectionView else { return UICollectionViewCell() }
            cell.layout()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagButtonCollectionViewCell.identifier, for: indexPath) as? TagButtonCollectionViewCell else { return UICollectionViewCell() }
            cell.layout()
            return cell
        }
    }
}

extension WriteViewController: UICollectionViewDelegate {
    
}
