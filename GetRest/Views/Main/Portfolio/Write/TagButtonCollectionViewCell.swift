//
//  TagButtonCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit

final class TagButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagButtonCollectionViewCell"
    
    lazy var tagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "WriteTagAddButton")
        return imageView
    }()
    
    func layout() {
        addSubview(tagImage)
        tagImage.snp.makeConstraints({
            $0.top.bottom.leading.trailing.equalToSuperview()
        })
    }
}
