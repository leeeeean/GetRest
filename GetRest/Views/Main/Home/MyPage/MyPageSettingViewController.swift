//
//  MyPageSettingViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/01.
//

import UIKit

enum Privacy: String, CaseIterable {
    case 쉬자이용약관 = "쉬자 이용약관"
    case 개인정보처리방침
    case 문의사항
    case 오픈소스라이선스 = "오픈소스 라이선스"
    case 회원탈퇴
    case 앱버전정보 = "앱 버전 정보"
}

final class MyPageSettingViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
        
        return tableView
    }()
    
    let appVersion: String
    let setting = Privacy.allCases
    
    init(version: String) {
        self.appVersion = version
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "설정"
    }
    
    private func layout() {
        navigationController?.navigationBar.topItem?.title = ""
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyPageSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == setting.count-1 {
            cell = UITableViewCell(
                style:  UITableViewCell.CellStyle.value1,
                reuseIdentifier: "SettingCell"
            )
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        }
        var config = cell.defaultContentConfiguration()
        config.attributedText = NSAttributedString(
            string: setting[indexPath.row].rawValue,
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 16.0, weight: .light)
            ])
        if indexPath.row == setting.count-1 {
            config.secondaryAttributedText = NSAttributedString(
                string: appVersion,
                attributes: [
                    .foregroundColor: UIColor.appColor(.baseGray),
                    .font: UIFont.systemFont(ofSize: 14.0, weight: .light)])
        }
        cell.selectionStyle = .none
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension MyPageSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController
        switch setting[indexPath.row] {
        case .쉬자이용약관:
            vc = TermsOfUse()
        case .개인정보처리방침:
            vc = PrivacyPolicy()
        case .문의사항:
            vc = Inquiry()
        case .오픈소스라이선스:
            vc = OpenSourceLicense()
        case .회원탈퇴:
            vc = Withdrawal()
        default:
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
