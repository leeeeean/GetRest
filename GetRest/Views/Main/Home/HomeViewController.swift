//
//  HomeViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {
        
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeader(name: "최리안")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


final class CustomHeader: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.image = UIImage(named: "HomeHeaderImage")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "\(name)님의 \n기록을 살펴볼까요?"
        label.font = .systemFont(ofSize: 24.0, weight: .light)
        label.textColor = .white
        label.attributeFontColor(
            target: name,
            font: .systemFont(ofSize: 24, weight: .bold),
            color: .white
        )
        
        label.numberOfLines = 2
        
        return label
    }()
    
    var name: String
    
    init(name: String) {
        self.name = name
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [imageView, label].forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(36.0)
        }
    }
}

extension UILabel {
    func attributeFontColor(target: String, font: UIFont, color: UIColor) {
        let text = text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: target)
        attributedString.addAttributes([
            .font: font,
            .foregroundColor: color
        ], range: range)
        self.attributedText = attributedString
    }
}
