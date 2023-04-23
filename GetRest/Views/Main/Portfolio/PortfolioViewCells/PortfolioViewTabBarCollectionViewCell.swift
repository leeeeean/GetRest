//
//  PortfolioViewTabBarCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit
import SnapKit

final class PortfolioViewTabBarCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioViewTabBarCollectionViewCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50.0
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var backgroundTabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func changeSelectedColor() {
        label.textColor = .appColor(.baseGreen)
        backgroundColor = .appColor(.baseGreen)
    }
    
    func changeNotSelectedColor() {
        label.textColor = .label
        backgroundColor = .clear
    }
    
    func layout(category: String) {
        label.text = category
        
        [backgroundTabBarView, indicatorView]
            .forEach{ addSubview($0) }
        
        backgroundTabBarView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
        })
        
        indicatorView.snp.makeConstraints({
            $0.top.equalTo(backgroundTabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(5.0)
        })
        
        backgroundTabBarView.addSubview(label)
        label.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
}
