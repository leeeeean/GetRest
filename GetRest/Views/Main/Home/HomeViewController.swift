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
        let tableView = UITableView()
        tableView.backgroundColor = .appColor(.baseGreen)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.tableHeaderView = HomeTableViewHeaderView(name: name)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HomeTableViewEmptyCell.self, forCellReuseIdentifier: HomeTableViewEmptyCell.identifier)
        tableView.register(HomeTableViewGraphCell.self, forCellReuseIdentifier: HomeTableViewGraphCell.identifier)
        
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
        navigationController?.navigationBar.barTintColor = .appColor(.baseGreen)
        
        view.backgroundColor = .appColor(.baseGreen)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

let data: [Int]? = nil

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let data = data,
              data.count != 0 else {
            return 700
        }
        
        if indexPath.row == 0 { return 200 }
        else { return 100 }
    }
}

extension HomeViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터가 0개일 때 return 1을 해줘야 함, 데이터 갯수가 있을 떄는 그냥 리턴
        guard let data = data,
              data.count != 0 else {
            return 1
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row != 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewGraphCell.identifier, for: indexPath) as? HomeTableViewGraphCell
            
            cell?.layout()
            return cell ?? UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewPortfolioCell.identifier, for: indexPath) as? HomeTableViewPortfolioCell
//        cell?.layout()
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         1 + (data?.count ?? 0)
    }
}
