//
//  WriteViewModel.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/25.
//

import Foundation
import RxCocoa
import RxSwift

final class WriteViewModel {
    let disposeBag = DisposeBag()
    
    let getCategory: Signal<String>
    let giveCategory = PublishSubject<String>()
    
    init() {
        getCategory = giveCategory
            .map({ str in
                print("giveCategory", str)
                return str
            })
            .asSignal(onErrorJustReturn: "Error")
    }
    
}

