//
//  PrivacyPolicy.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

final class PrivacyPolicy: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        title = "개인정보처리방침"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
