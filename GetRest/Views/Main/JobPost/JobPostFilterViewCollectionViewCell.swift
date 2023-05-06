//
//  JobPostFilterViewCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/06.
//

import UIKit

protocol JobPostFilterButtonTappedDelegate: AnyObject {
    func filterButtonTapped(button: UIButton, isSelected: Bool)
}

final class JobPostFilterViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "JobPostFilterViewCollectionViewCell"
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.appColor(.baseGreen).cgColor
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.appColor(.baseGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .medium)
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)

        return button
    }()
    
    weak var delegate: JobPostFilterButtonTappedDelegate?
    
    func setData(data: String) {
        categoryButton.setTitle(data, for: .normal)

        layout()
    }
    
    private func layout() {
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func categoryButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        
        if button.isSelected {
            button.backgroundColor = .appColor(.baseGreen)
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.appColor(.baseGreen), for: .normal)
        }
        
        delegate?.filterButtonTapped(button: button, isSelected: button.isSelected)
    }
}
