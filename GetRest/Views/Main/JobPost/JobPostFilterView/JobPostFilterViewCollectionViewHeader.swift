//
//  JobPostFilterViewCollectionViewHeader.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/07.
//

import UIKit

final class JobPostFilterViewCollectionViewHeader:
    UICollectionReusableView {
    static let identifier = "JobPostFilterViewCollectionViewHeader"

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        
        return label
    }()
    
    func setData(data: String) {
        label.text = data
        
        layout()
    }
    
    private func layout() {
        backgroundColor = .appColor(.lightGreen)
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
    }
}
