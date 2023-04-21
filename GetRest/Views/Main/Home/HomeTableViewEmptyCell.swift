//
//  HomeTableViewEmptyCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit

final class HomeTableViewEmptyCell: UITableViewCell {
    static let identifier = "HomeTableViewEmptyCell"
    
    private lazy var backgrountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HomeNoData")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "잉?\n표기할 경험 기록이 없어요!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .appColor(.baseGray)
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appColor(.baseGreen)
        button.setTitle("기록해볼게요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.layer.cornerRadius = 6.0
        
        return button
    }()
    
    func layout() {
        [backgrountImageView, emptyImageView, emptyLabel, writeButton]
            .forEach { addSubview($0) }
        
        backgrountImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(800)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(backgrountImageView.snp.top).inset(70.0)
            $0.centerX.equalTo(backgrountImageView.snp.centerX)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalTo(emptyImageView.snp.centerX)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(20.0)
        }
        
        writeButton.snp.makeConstraints {
            $0.centerX.equalTo(emptyLabel.snp.centerX)
            $0.top.equalTo(emptyLabel.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(70.0)
            $0.height.equalTo(40.0)
        }
    }
}


