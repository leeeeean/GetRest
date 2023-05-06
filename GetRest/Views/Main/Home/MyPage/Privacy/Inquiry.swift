//
//  Inquiry.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

final class Inquiry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        title = "문의사항"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
