//
//  HomeTableViewHeaderView.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit

final class HomeTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "HomeTableViewHeaderView"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HomeHeader")
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "\(name)님의 \n기록을 살펴볼까요?"
        label.font = .systemFont(ofSize: 24.0, weight: .light)
        label.textColor = .white
        label.attributeFontColor(
            target: name,
            font: .systemFont(ofSize: 24, weight: .bold),
            color: .white
        )
        
        label.numberOfLines = 2
        
        return label
    }()
    
    var name: String
    
    override init(reuseIdentifier: String?) {
        self.name = "홍길동"
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    init(name: String) {
        self.name = name
        super.init(reuseIdentifier: "HomeTableViewHeaderView")
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        
        let imageHeight = imageView.image?.size.height
        let imageWidth = imageView.image?.size.width
        let width = UIScreen.main.bounds.size.width
        let height = imageHeight! * width / imageWidth!
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        backgroundColor = .systemBackground
        [imageView, label].forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(36.0)
        }
    }
}
