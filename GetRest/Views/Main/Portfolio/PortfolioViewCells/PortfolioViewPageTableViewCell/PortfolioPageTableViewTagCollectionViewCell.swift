//
//  PortfolioPageTableViewTagCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/08.
//

import UIKit

final class PortfolioPageTableViewTagCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioPageTableViewTagCollectionViewCell"
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    func setData(tag: String) {
        tagLabel.text = tag
        
        layout()
    }
    
    private func layout() {
        contentView.layer.cornerRadius = 14.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 0.7
        contentView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
