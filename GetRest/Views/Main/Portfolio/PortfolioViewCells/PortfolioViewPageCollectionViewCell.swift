//
//  PortfolioViewPageCollectionViewCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/23.
//

import UIKit
import SnapKit

protocol TappedTableViewCellDelegate: AnyObject {
    func navigationToReadViewController(portfolio: Portfolio)
}

final class PortfolioViewPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioViewPageCollectionViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PortfolioPageTableViewCell.self, forCellReuseIdentifier: PortfolioPageTableViewCell.identifier)
        
        return tableView
    }()
    
    private var portfolios: [Portfolio]?
    var delegate: TappedTableViewCellDelegate?
    
    func setData(portfolios: [Portfolio]) {
        self.portfolios = portfolios
        tableView.reloadData()
        
        layout()
    }
    
    private func layout() {
        addSubview(tableView)
        backgroundColor = .white
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PortfolioViewPageCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioPageTableViewCell.identifier, for: indexPath) as? PortfolioPageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(portfolio: portfolios![indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigationToReadViewController(portfolio: portfolios![indexPath.row])
    }
}

extension PortfolioViewPageCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156.0
    }
}
