//
//  HomeTableViewQuarterHeaderView.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/22.
//

import UIKit

final class HomeTableViewQuarterHeaderView: UITableViewHeaderFooterView {
    static let identifier = "HomeTableViewQuarterHeaderView"
    
    private lazy var quarterLabel: UILabel = {
        let label = UILabel()
        label.text = "\(year) \(quarter)분기"
        label.font = .systemFont(ofSize: 18.0, weight: .bold)

        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    var year: String
    var quarter: String
    
    override init(reuseIdentifier: String?) {
        year = "2023"
        quarter = "4"
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    init(year: String, quarter: String) {
        self.year = year
        self.quarter = quarter
        
        super.init(reuseIdentifier: "HomeTableViewQuarterHeaderView")
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.backgroundColor = .white
        
        [quarterLabel, lineView]
            .forEach { addSubview($0) }
        
        quarterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.leading.equalToSuperview().inset(24.0)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.equalTo(quarterLabel.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalTo(quarterLabel.snp.centerY)
            $0.height.equalTo(1.0)
        }
    }
}
