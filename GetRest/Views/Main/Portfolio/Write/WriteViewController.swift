//
//  WriteViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class WriteViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.overrideUserInterfaceStyle = .light
        scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: 2)!
        return scrollView
    }()
    
    private lazy var scrollBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.lightGray)
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WirteAddImageButton")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var writeView: UIView = {
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
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .medium)
        textField.textColor = .label
        textField.attributedPlaceholder = NSAttributedString(
            string: "입력하세요",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .medium)]
        )
        textField.delegate = self

        return textField
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
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("항목", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        button.setTitleColor(.appColor(.baseGray), for: .normal)
        button.contentHorizontalAlignment = .leading
        button.isUserInteractionEnabled = true
        
        return button
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
    
    private lazy var dateTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("YYYY.MM.DD ~ YYYY.MM.DD", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        button.setTitleColor(.appColor(.baseGray), for: .normal)
        button.contentHorizontalAlignment = .leading

        return button
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
        textView.textColor = .appColor(.baseGray)
        textView.font = .systemFont(ofSize: 16.0)
        textView.delegate = self
        textView.isScrollEnabled = true
        
        return textView
    }()
    
    private lazy var keyboardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var keyboardOffset = 291.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind(viewModel)
                
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(makeKeboardHide))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(whenKeyBoardHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    let disposeBag = DisposeBag()
    let viewModel = WriteViewModel()
    let categorySelectedViewModel = CategorySelectViewModel()

    func bind(_ viewModel: WriteViewModel) {
        
        categoryButton.rx.tap
            .bind(onNext: { [weak self] _ in
                guard let self else { return }
                let vc = CategorySelectViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
                
                vc.viewModel
                    .categorySelected
                    .bind(to: categoryButton.rx.title())
                    .disposed(by: disposeBag)
                vc.viewModel
                    .categorySelected
                    .bind(onNext: { [weak self] _ in
                        guard let self else { return }
                        self.categoryButton.setTitleColor(.label, for: .normal)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        dateTextButton.rx.tap
            .bind { [weak self] _ in
                guard let self else { return }
                let vc = CalendarViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
                
                vc.viewModel
                    .setDate
                    .bind(to: dateTextButton.rx.title())
                    .disposed(by: disposeBag)
                vc.viewModel
                    .setDate
                    .bind(onNext: { [weak self] _ in
                        guard let self else { return }
                        self.dateTextButton.setTitleColor(.label, for: .normal)
                    })
                    .disposed(by: disposeBag)
            }
            .disposed(by: disposeBag)
    }

    private func layout() {
        view.tintColor = .appColor(.baseGreen)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.down.to.line"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.title = "기록작성"
        navigationController?.navigationBar.tintColor = .appColor(.baseGreen)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints({
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
        
        scrollBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollBackgroundView)
        scrollBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
        }
        
        [backgroundView, writeView, keyboardView]
            .forEach({ scrollBackgroundView.addSubview($0) })
        backgroundView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(240.0)
        }
        writeView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).inset(220.0)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(500.0)
        }
        keyboardView.snp.makeConstraints({
            $0.top.equalTo(writeView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(10.0)
        })
        
        backgroundView.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(140.0)
        }
        
        [
            titleCategoryDateStackView,
            tagCollectionView,
            lineView,
            writeTextView
        ].forEach({ writeView.addSubview($0) })
        
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
        writeTextView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(titleCategoryDateStackView)
            $0.top.equalTo(lineView.snp.bottom).offset(viewOffset)
        }
        
        let labelWidth:CGFloat = 80.0
        [titleLabel, titleTextField]
            .forEach({ titleStackView.addArrangedSubview($0) })
        titleLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [categoryLabel, categoryButton]
            .forEach({ categoryStackView.addArrangedSubview($0) })
        categoryLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [dateLabel, dateTextButton]
            .forEach({ dateStackView.addArrangedSubview($0) })
        dateLabel.snp.makeConstraints({ $0.width.equalTo(labelWidth) })
        [titleStackView, categoryStackView, dateStackView]
            .forEach({ titleCategoryDateStackView.addArrangedSubview($0) })
        
    }
    var data = ["동아ddddd리","ddddd직장", "손ddd해보험", "제주도"]
}

extension WriteViewController {
    @objc func saveButtonTapped() {
        
    }
    
    @objc func whenKeyBoardHide(notification: NSNotification) {
        scrollView.setContentOffset(
            CGPoint(x: 0, y: 0),
            animated: true
        )
    }
    
    @objc func makeKeboardHide() {
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let indexPath = IndexPath(row: textField.tag, section: 0)
        data[textField.tag] = textField.text ?? "-"
        UIView.animate(withDuration: 0.1, animations: {
            self.tagCollectionView.collectionViewLayout.invalidateLayout()
        })
        print(data)

    }
    /* ************* cell의 레이아웃을 실시간으로 변경하는 방법 ******************
            collectionView.collectionViewLayout.invalidateLayout()
    */
    
    @objc func longPressGoToDelete(_ gesture: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "닫기", style: .cancel)
        let confirmAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let self else { return }
            let index = gesture.view?.tag
            gesture.minimumPressDuration = 1
            self.data.remove(at: index!)
            self.tagCollectionView.reloadData()
        }
        [cancleAction, confirmAction].forEach({ alert.addAction($0) })
        present(alert, animated: true)
    }
}

extension WriteViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension WriteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indexPath = IndexPath(row: textField.tag, section: 0)
        if textField.text == "" { data.remove(at: indexPath.row) }
        tagCollectionView.reloadData()
    }
}
extension WriteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        scrollView.setContentOffset(
            CGPoint(x: 0, y: keyboardOffset/2),
            animated: true
        )
        keyboardView.snp.makeConstraints({
            $0.height.equalTo(keyboardOffset)
        })
        keyboardView.invalidateIntrinsicContentSize()
        scrollView.contentSize = CGSize(
            width: scrollView.contentSize.width,
            height: scrollView.contentSize.height + keyboardOffset/2
        )
        scrollView.invalidateIntrinsicContentSize()
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.contentSize = CGSize(
            width: scrollView.contentSize.width,
            height: scrollView.contentSize.height - keyboardOffset/2
        )
        scrollView.invalidateIntrinsicContentSize()
        keyboardView.snp.makeConstraints({
            $0.height.equalTo(10)
        })
        keyboardView.invalidateIntrinsicContentSize()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "자기소개서를 작성해보세요" {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil,
            textView.text == "" {
            textView.text = "자기소개서를 작성해보세요"
            textView.textColor = .appColor(.baseGray)
            return
        } else {
            textView.textColor = .label
        }
        
        let enterCount = textView.text.filter{ $0 == "\n"}.count
        if enterCount >= 5 {
            let lineHeight: CGFloat = CGFloat(textView.font!.lineHeight) * CGFloat((enterCount - 5))
            
            scrollView.setContentOffset(
                CGPoint(x: 0, y: keyboardOffset/2 + lineHeight),
                animated: true
            )
            keyboardView.snp.makeConstraints({
                $0.height.equalTo(keyboardOffset)
            })
            keyboardView.invalidateIntrinsicContentSize()
            scrollView.contentSize = CGSize(
                width: scrollView.contentSize.width,
                height: scrollView.contentSize.height + keyboardOffset/2 + lineHeight
            )
            print(scrollView.contentSize)
            scrollView.invalidateIntrinsicContentSize()
        }
        
    }
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < data.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TagTextFieldCollectionView.identifier,
                for: indexPath
            ) as? TagTextFieldCollectionView else { return .zero }
            
            let textCount = data[indexPath.row].count
            cell.tagTextField.text = data[indexPath.row]

            guard textCount != 0 else {
                return CGSize(width: 60.0, height: 24.0)
            }
            if data[indexPath.row] == "-" { return CGSize(width: 0, height: 0) }
            let textFieldStringWidth = cell.tagTextField.intrinsicContentSize.width

            return CGSize(width: textFieldStringWidth, height: 24.0)
        } else {
            return CGSize(width: 24.0, height: 24.0)
        }
    }
}

extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count + 1
    }
    
    func collectionView(_ collectionViews: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < data.count {
            guard let cell = collectionViews.dequeueReusableCell(withReuseIdentifier: TagTextFieldCollectionView.identifier, for: indexPath) as? TagTextFieldCollectionView else { return UICollectionViewCell() }
            cell.layout()
            
            cell.tagTextField.text = data[indexPath.row]
            cell.tagTextField.tag = indexPath.row
            cell.tagTextField.addTarget(
                self,
                action: #selector(textFieldDidChange),
                for: .editingChanged
            )
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGoToDelete))
            gesture.view?.tag = indexPath.row
            cell.tagTextField.addGestureRecognizer(gesture)
            return cell
        } else {
            guard let cell = collectionViews.dequeueReusableCell(withReuseIdentifier: TagButtonCollectionViewCell.identifier, for: indexPath) as? TagButtonCollectionViewCell else { return UICollectionViewCell() }
            cell.layout()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let _ = collectionView.cellForItem(at: indexPath) as? TagButtonCollectionViewCell else { return }
        guard let cell = collectionView.cellForItem(
            at: IndexPath(
                row: indexPath.row - 1,
                section: 0
            )
        ) as? TagTextFieldCollectionView else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        if cell.tagTextField.text == "" {
            return
        }
        data.append("")
        collectionView.reloadData()

        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x + 80, y: 0), animated: true)
        
    }
    
}

extension WriteViewController: UICollectionViewDelegate {
    
}

