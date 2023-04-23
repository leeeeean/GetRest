//
//  PortfolioViewEmptyCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit
import SnapKit

final class PortfolioViewEmptyCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioViewEmptyCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PortfolioNoData")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "아직 기록을 하지 않았어요.\n어떤 경험을 했는지 알려주세요!"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .appColor(.baseGray)
        
        return label
    }()
    
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록해볼게요", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .appColor(.middleGreen)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        return stackView
    }()
    
    @objc func writeButtonTapped() {
        moveToWritePage!()
    }
    
    var moveToWritePage: (() -> Void)? = nil
    
    func layout() {
        
        addSubview(stackView)
        stackView.snp.makeConstraints({
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(280.0)
        })
        
        [imageView, label, writeButton]
            .forEach { stackView.addArrangedSubview($0) }
        writeButton.snp.makeConstraints({
            $0.height.equalTo(40.0)
        })
    }
}
