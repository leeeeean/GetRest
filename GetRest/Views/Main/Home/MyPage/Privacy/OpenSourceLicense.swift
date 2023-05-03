//
//  OpenSourceLicense.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

final class OpenSourceLicense: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        title = "오픈소스 라이선스"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
