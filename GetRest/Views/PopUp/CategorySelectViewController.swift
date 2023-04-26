//
//  CategorySelectViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/25.
//

import UIKit
import RxCocoa
import RxSwift

final class CategorySelectViewController: UIViewController {
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
    
    private lazy var categoryBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = .appColor(.baseGreen)
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = .white
        
        return label
    }()
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50.0
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = CategorySelectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind(viewModel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true)
    }
    
    var category = ["대외활동", "학교활동", "공모전", "경력사항", "기타"]
    func bind(_ viewModel: CategorySelectViewModel) {
        
        categoryTableView.rx.itemSelected
            .map { [weak self] indexPath -> String in
                guard let self else { return "" }
                self.dismiss(animated: true)
                return self.category[indexPath.row]
            }
            .bind(to: viewModel.categorySelected)
            .disposed(by: disposeBag)
        
    }
    
    private func layout() {
        view.backgroundColor = .clear
        
        [backgroundView, categoryBackgroundView]
            .forEach({ view.addSubview($0) })
        backgroundView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        categoryBackgroundView.snp.makeConstraints({
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(500)
        })
        
        [categoryLabel, categoryTableView]
            .forEach({ categoryBackgroundView.addSubview($0) })
        categoryLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64.0)
            $0.top.equalTo(categoryBackgroundView.snp.top)
        }
        categoryTableView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CategorySelectViewController: UITableViewDelegate {
    
}

extension CategorySelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = category[indexPath.row]
        content.attributedText = NSAttributedString(
            string: category[indexPath.row],
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
            ]
        )
        cell.contentConfiguration = content
        return cell
    }
}
