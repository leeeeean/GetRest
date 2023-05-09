//
//  TagLabelCollectionView.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/09.
//

import UIKit

final class TagLabelCollectionView: UICollectionViewCell {
    static let identifier = "TagLabelCollectionView"
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0)
        
        return label
    }()
    
    func setData(tag: String) {
        tagLabel.text = tag
        layout()
    }
    
    private func layout() {
        contentView.backgroundColor = .appColor(.baseGreen)
        contentView.layer.cornerRadius = 15.0
        
        contentView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
