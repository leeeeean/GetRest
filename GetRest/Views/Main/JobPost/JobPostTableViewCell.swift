//
//  JobPostTableViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

protocol ButtonTappedDelegate: AnyObject {
    func starButtonTapped(_ button: UIButton)
}

final class JobPostTableViewCell: UITableViewCell {
    static let identifier = "JobPostTableViewCell"
    
    private lazy var enterpriseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "JobPostEmptyEnterpriseLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appColor(.baseGreen)
        
        return view
    }()
    
    private lazy var enterpriseLabel: UILabel = {
        let label = UILabel()
        label.text = "기업명"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        
        return label
    }()
    
    private lazy var partLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 개발자"
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.textColor = .appColor(.darkGray)

        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "~05월 06일 18시 00분"
        label.font = .systemFont(ofSize: 10.0, weight: .light)
        label.textColor = .appColor(.baseGray)
        
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "JobPostSmallStar"), for: .normal)
        button.setImage(UIImage(named: "JobPostSmallStarFill"), for: .selected)
        button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: ButtonTappedDelegate?
    
    func setData(data: Data) {
        layout()
        
        let buttonImage: UIImage? = data.star ?
        UIImage(named: "JobPostSmallStarFill") :
        UIImage(named: "JobPostSmallStar")
        starButton.imageView?.image = buttonImage
        
        enterpriseLabel.text = data.enterprise
        
        enterpriseImageView.image = UIImage(named: data.image)
        
        partLabel.text = data.part
        
        dateLabel.text = data.date
    }
    
    func layout() {
        [
            enterpriseImageView,
            lineView,
            enterpriseLabel,
            partLabel,
            dateLabel,
            starButton
        ].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16.0
        enterpriseImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(inset)
            $0.width.equalTo(100.0)
        }
        lineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.0)
            $0.leading.equalTo(enterpriseImageView.snp.trailing).offset(inset)
            $0.width.equalTo(2.0)
        }
        enterpriseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(inset)
            $0.leading.equalTo(lineView.snp.trailing).offset(inset)
        }
        partLabel.snp.makeConstraints {
            $0.top.equalTo(enterpriseLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(enterpriseLabel.snp.leading)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(partLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(partLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(inset)
        }
        starButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(inset)
            $0.width.height.equalTo(24.0)
        }
    }
}

extension JobPostTableViewCell {
    @objc func starButtonTapped(_ button: UIButton) {
        delegate?.starButtonTapped(button)
    }
}
