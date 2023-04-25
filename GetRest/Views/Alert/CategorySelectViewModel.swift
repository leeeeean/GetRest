//
//  CategorySelectViewModel.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CategorySelectViewModel {
    let disposeBag = DisposeBag()
    let writeViewModel = WriteViewModel()
    
    let categorySelected = PublishSubject<String>()
    
    
    init() {
        categorySelected
            .map({ str in
                print("categorySelected",str)
                return str
            })
            .bind(to: writeViewModel.giveCategory)
            .disposed(by: disposeBag)
    }
}
