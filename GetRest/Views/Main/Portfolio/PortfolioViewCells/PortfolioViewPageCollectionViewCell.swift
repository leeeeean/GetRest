//
//  PortfolioViewPageCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit
import SnapKit

final class PortfolioViewPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioViewPageCollectionViewCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "category"
        
        return label
    }()
    
    func layout() {
        addSubview(label)
        backgroundColor = .white
        
        label.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
}
