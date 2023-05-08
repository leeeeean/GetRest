//
//  JobPostViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit
import RxCocoa
import RxSwift

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

protocol JobPostViewToJobPostHeaderViewProtocol: AnyObject {
    func calendarViewDataToHeaderTextField(date: String)
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .appColor(.baseGreen)
        searchBar.searchTextField.tintColor = .appColor(.baseGreen)
        searchBar.searchTextField.leftView?.tintColor = .appColor(.baseGreen)
        searchBar.searchTextField.backgroundColor = .appColor(.lightGreen)
        searchBar.delegate = self
        
        return searchBar
    }()
    
    let data = Data.shared
    private var currentData = Data.shared
    
    weak var delegate: JobPostViewToJobPostHeaderViewProtocol?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarLayout()
    }
    
    func bind() {
        
    }
    
    private func navigationBarLayout() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.appColor(.baseGreen)]
        appearance.shadowColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func layout() {
        title = "채용공고"
        showSearchBarButton(shouldShow: true)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.baseGreen).cgColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0, weight: .medium)
        ]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "magnifyingglass"),
                style: .plain,
                target: self,
                action: #selector(showSearchBar)
            )
            navigationItem.rightBarButtonItem?.tintColor = .appColor(.baseGreen)

        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}
extension JobPostViewController {
    @objc func showSearchBar() {
        search(shouldShow: true)
    }
        
}

extension JobPostViewController: HeaderButtonTappedDelegate {
    func headerStarButtonTapped(isStarFill: Bool) {
        if isStarFill {
            currentData = data.filter{ $0.star == true }
            print("data change")
        } else {
            currentData = data
        }
        tableView.reloadData()
    }
    
    func headerCalendarButtonTapped(date: String) {
        let vc = JobPostCalendarViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.currentDate = date
        vc.delegate = self // JobPostViewController <-> JobPostCalendarViewController
        
        present(vc, animated: true)
    }
    
    func headerFilterButtonTapped() {
        let vc = JobPostFilterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension JobPostViewController: JobPostCalendarButtonTappedDelegate {
    func calendarConfirmButtonTapped(date: String) {
        delegate?.calendarViewDataToHeaderTextField(date: date)
    }
}

extension JobPostViewController: TableViewCellButtonTappedDelegate {
    func starButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
    }
}

extension JobPostViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        searchBar.text = ""
    }
}

extension JobPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobPostHeaderView.identifier) as? JobPostHeaderView else { return UIView() }
        headerView.delegate = self
        delegate = headerView // JobPostViewController <-> JobPostHeaderView
        
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
        
        cell.setData(data: currentData[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
}
