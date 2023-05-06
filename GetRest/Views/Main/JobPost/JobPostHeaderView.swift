//
//  JobPostHeaderView.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

protocol HeaderButtonTappedDelegate: AnyObject {
    func headerStarButtonTapped(isStarFill: Bool)
}

final class JobPostHeaderView: UITableViewHeaderFooterView {
    static let identifier = "JobPostHeaderView"
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var calendarLabel: UILabel = {
        let label = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        label.text = formatter.string(from: Date())
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.textColor = .appColor(.baseGreen)

        return label
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "JobPostCalendarDropdown"), for: .normal)
        button.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "JobPostFilter"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "JobPostStarFill"), for: .selected)
        button.setImage(UIImage(named: "JobPostStar"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        button.tag = 0
        
        return button
    }()
    
    weak var delegate: HeaderButtonTappedDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: JobPostHeaderView.identifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 0.2
        
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [
            calendarLabel,
            calendarButton,
            filterButton,
            starButton
        ].forEach{ view.addSubview($0) }
        calendarLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.centerY.equalToSuperview()
        }
        calendarButton.snp.makeConstraints {
            $0.leading.equalTo(calendarLabel.snp.trailing)
            $0.centerY.equalTo(calendarLabel.snp.centerY)
            $0.height.equalTo(24.0)
        }
        starButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(24.0)
        }
        filterButton.snp.makeConstraints {
            $0.centerY.equalTo(starButton.snp.centerY)
            $0.trailing.equalTo(starButton.snp.leading).offset(-20.0)
        }
    }
}

extension JobPostHeaderView {
    @objc func calendarButtonTapped(_ button: UIButton) {
        print("calendar")
        // calendar view
    }
    
    @objc func filterButtonTapped(_ button: UIButton) {
        print("filter")
        // filter view
    }
    
    @objc func starButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        delegate?.headerStarButtonTapped(isStarFill: button.isSelected)
    }
}
