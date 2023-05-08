//
//  HomeTableViewPortfolioCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/22.
//

import UIKit

final class HomeTableViewPortfolioCell : UITableViewCell {
    static let identifier = "HomeTableViewPortfolioCell"
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.lightGreen)
        view.layer.cornerRadius = 6.0
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal )
        button.tintColor = .appColor(.darkGray)
        
        return button
    }()
    
    
    func setData(portfolio: Portfolio) {
        titleLabel.text = portfolio.title
        dateLabel.text = portfolio.date
        
        layout()
    }
    
    private func layout() {
        [view, titleLabel, dateLabel, button]
            .forEach { addSubview($0) }
        
        view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(8.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view).inset(16.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.0)
            $0.bottom.leading.equalTo(view).inset(16.0)
        }
        
        button.snp.makeConstraints {
            $0.trailing.top.bottom.equalTo(view).inset(16.0)
        }
    }
}
