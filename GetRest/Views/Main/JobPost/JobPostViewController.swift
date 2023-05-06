//
//  JobPostViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit

struct Data {
    let image: String
    let enterprise: String
    let part: String
    let date: String
    let star: Bool
    
    static let shared = [
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false),
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false),
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false),
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostEmptyEnterpriseLogo", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: true),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false),
        Data(image: "JobPostNaver", enterprise: "네이버", part: "iOS 앱 개발자", date: "~06월 19일 18시 00분", star: false)
    ]
}

final class JobPostViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(JobPostHeaderView.self, forHeaderFooterViewReuseIdentifier: JobPostHeaderView.identifier)
        tableView.register(JobPostTableViewCell.self, forCellReuseIdentifier: "JobPostTableViewCell")
        
        return tableView
    }()
    
    let data = Data.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    func bind() {
        
    }
    
    private func layout() {
        title = "채용공고"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .appColor(.baseGreen)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.baseGreen).cgColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0, weight: .medium)
        ]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension JobPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobPostHeaderView.identifier) as? JobPostHeaderView else { return UIView() }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56.0
    }
}

extension JobPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobPostTableViewCell", for: indexPath) as? JobPostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(data: data[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

extension JobPostViewController: ButtonTappedDelegate {
    func starButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
    }
}
