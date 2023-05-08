//
//  HomeViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.tableHeaderView = HomeTableViewHeaderView(name: name)
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 5
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HomeTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeTableViewHeaderView.identifier)
        tableView.register(HomeTableViewQuarterHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeTableViewQuarterHeaderView.identifier)
        tableView.register(HomeTableViewEmptyCell.self, forCellReuseIdentifier: HomeTableViewEmptyCell.identifier)
        tableView.register(HomeTableViewGraphCell.self, forCellReuseIdentifier: HomeTableViewGraphCell.identifier)
        tableView.register(HomeTableViewPortfolioCell.self, forCellReuseIdentifier: HomeTableViewPortfolioCell.identifier)
        
        
        return tableView
    }()
    
    var name: String = "홍길동"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {

    }
    
    private func layout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "HomeButton"),
            style: .plain,
            target: self,
            action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.fill"),
            style: .plain,
            target: self,
            action: #selector(myPageButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .appColor(.baseGreen)
        navigationController?.navigationBar.backgroundColor = .appColor(.baseGreen)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .appColor(.baseGreen)
        appearance.shadowColor = .clear // remove navigationBar line
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

var data: [[Int]]? = [[1,2,3], [1,2], [1,2,3,4]]

extension HomeViewController {
    @objc func myPageButtonTapped() {
        let vc = MyPageViewController(name: name, accountID: "getrest1234")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return CGFloat.leastNormalMagnitude }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return UIView(frame: .zero) }
        return HomeTableViewQuarterHeaderView(year: "2023", quarter: "3")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let data = data,
              data.count != 0 else {
            return 500
        }

        if indexPath.row == 0 && indexPath.section == 0 { return 200 }
        return 100
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data,
              data.count != 0 else {
            return 1
        }
        if section == 0 { return 1 }
        return Portfolio.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data,
              data.count != 0 else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewEmptyCell.identifier, for: indexPath) as? HomeTableViewEmptyCell
            else { return UITableViewCell() }
            cell.layout()
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 0 && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewGraphCell.identifier, for: indexPath) as? HomeTableViewGraphCell
            else { return UITableViewCell() }
            cell.layout()
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewPortfolioCell.identifier, for: indexPath) as? HomeTableViewPortfolioCell
        else { return UITableViewCell() }
        
        cell.setData(portfolio: Portfolio.shared[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let data = data,
              data.count != 0 else {
            return 1
        }
        return data.count+1
    }
    
}
