//
//  PortfolioPageTableViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/08.
//

import UIKit

final class PortfolioPageTableViewCell: UITableViewCell {
    static let identifier = "PortfolioPageTableViewCell"
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PortfolioBackgroundImageEmpty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PortfolioPageTableViewTagCollectionViewCell.self, forCellWithReuseIdentifier: PortfolioPageTableViewTagCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private var portfolio: Portfolio?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8.0
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 24.0, left: 16.0, bottom: 0, right: 16.0))
    }
    
    func setData(portfolio: Portfolio) {
        self.portfolio = portfolio
        backgroundImageView.image = portfolio.getImage
        titleLabel.text = portfolio.title
        dateLabel.text = portfolio.date
        
        layout()
    }
    
    private func layout() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [titleLabel, dateLabel, tagCollectionView]
            .forEach{ backgroundImageView.addSubview($0) }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(28.0)
            $0.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        tagCollectionView.snp.makeConstraints{
            let itemWidth = portfolio!.tag.reduce(0, { partialResult, tag in
                return tag.count*10 + 10 + partialResult
            })
            let width = itemWidth + 12*(portfolio!.tag.count-1)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
            $0.height.equalTo(30.0)
            $0.width.equalTo(width)
            $0.centerX.equalToSuperview()
        }
    }
}

extension PortfolioPageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return portfolio?.tag.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioPageTableViewTagCollectionViewCell.identifier, for: indexPath) as? PortfolioPageTableViewTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(tag: portfolio!.tag[indexPath.row])
        return cell
    }
}

extension PortfolioPageTableViewCell: UICollectionViewDelegate {

}

extension PortfolioPageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = portfolio!.tag[indexPath.row].count * 10 + 10
        return CGSize(width: width, height: 30)
    }
}
