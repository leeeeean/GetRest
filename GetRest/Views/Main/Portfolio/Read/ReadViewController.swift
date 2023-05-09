//
//  ReadViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/09.
//

import UIKit

final class ReadViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.bounces = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.isScrollEnabled = true
//        scrollView.isUserInteractionEnabled = true
//        scrollView.overrideUserInterfaceStyle = .light
//        scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: 2)!
        
        return scrollView
    }()
    
    private lazy var scrollBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .appColor(.baseGreen)
        label.text = "제목"
        
        return label
    }()
    
    private lazy var titleDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .label

        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .leading,
            distribution: .fill
        )
        
        return stackView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .appColor(.baseGreen)
        label.text = "카테고리"
        label.isUserInteractionEnabled = true

        return label
    }()
    
    private lazy var categoryDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .center,
            distribution: .fillProportionally
        )
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = .appColor(.baseGreen)
        label.text = "기간"

        return label
    }()
    
    private lazy var dateDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackViewSetting(
            stackView: stackView,
            axis: .horizontal,
            spacing: 4.0,
            alignment: .leading,
            distribution: .fill
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
            distribution: .equalSpacing
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
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TagLabelCollectionView.self, forCellWithReuseIdentifier: TagLabelCollectionView.identifier)

        return collectionView
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.baseGray)
        
        return view
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let portfolio: Portfolio
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    private func setData() {
        imageView.image = portfolio.getImage
        titleDataLabel.text = portfolio.title
        categoryDataLabel.text = portfolio.category.rawValue
        dateDataLabel.text = portfolio.date
        contentsLabel.text = portfolio.content
        
        layout()
    }
    
    private func layout() {
        rightBarButtonSetting()
        navigationItem.title = "기록보기"
        navigationController?.navigationBar.tintColor = .appColor(.baseGreen)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints({
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
        
        scrollView.addSubview(scrollBackgroundView)
        scrollBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
        }
        
        [imageView, contentView]
            .forEach({ scrollBackgroundView.addSubview($0) })
        imageView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(240.0)
        }
        contentView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top).inset(220.0)
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(500.0)
        }
        
        [
            titleCategoryDateStackView,
            tagCollectionView,
            lineView,
            contentsLabel
        ].forEach({ contentView.addSubview($0) })
        
        let viewOffset: CGFloat = 16.0
        titleCategoryDateStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.0)
            $0.trailing.leading.equalToSuperview().inset(20.0)
            $0.height.equalTo(92.0)
        }
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleCategoryDateStackView.snp.bottom).offset(viewOffset)
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
            $0.height.equalTo(40.0)
        }
        lineView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(viewOffset)
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
        }
        contentsLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
            $0.top.equalTo(lineView.snp.bottom).offset(viewOffset)
        }
        
        let labelWidth:CGFloat = 80.0
        [titleLabel, titleDataLabel]
            .forEach({ titleStackView.addArrangedSubview($0) })
        titleLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [categoryLabel, categoryDataLabel]
            .forEach({ categoryStackView.addArrangedSubview($0) })
        categoryLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [dateLabel, dateDataLabel]
            .forEach({ dateStackView.addArrangedSubview($0) })
        dateLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [titleStackView, categoryStackView, dateStackView]
            .forEach({ titleCategoryDateStackView.addArrangedSubview($0) })
    }
    
    private func rightBarButtonSetting() {
        let deleteButtonImage = UIImage(named: "ReadDeleteButton")!
        let deleteButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: deleteButtonImage.size.width,
            height: deleteButtonImage.size.height))
        deleteButton.setImage(deleteButtonImage, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        let modifyButtonImage = UIImage(named: "ReadModifyButton")!
        let modifyButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: modifyButtonImage.size.width,
            height: modifyButtonImage.size.height))
        modifyButton.setImage(modifyButtonImage, for: .normal)
        modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
        
        let deleteButtonItem = UIBarButtonItem(customView: deleteButton)
        let modifyButtonItem = UIBarButtonItem(customView: modifyButton)
        navigationItem.rightBarButtonItems = [deleteButtonItem, modifyButtonItem]
    }
}

extension ReadViewController {
    @objc func deleteButtonTapped() {
        
    }
    
    @objc func modifyButtonTapped() {
        
    }
}

extension ReadViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = portfolio.tag[indexPath.row].count*12 + 32
        
        return CGSize(width: Double(width), height: 30.0)
    }
}

extension ReadViewController: UICollectionViewDelegate {
    
}

extension ReadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        portfolio.tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagLabelCollectionView.identifier, for: indexPath) as? TagLabelCollectionView else { return UICollectionViewCell() }
        
        cell.setData(tag: portfolio.tag[indexPath.row])
        return cell
    }
}
