//
//  TermsOfUse.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/03.
//

import UIKit

final class TermsOfUse: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        title = "쉬자 이용약관"
        navigationController?.navigationBar.topItem?.title = ""
    }
}


