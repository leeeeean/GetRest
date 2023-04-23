//
//  TagButtonCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit

final class TagButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagButtonCollectionViewCell"
    
    private lazy var tagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "WriteTagAddButton"), for: .normal)
        
        return button
    }()
    
    func layout() {
        addSubview(tagButton)
        tagButton.snp.makeConstraints({
            $0.top.bottom.leading.trailing.equalToSuperview()
        })
    }
}
