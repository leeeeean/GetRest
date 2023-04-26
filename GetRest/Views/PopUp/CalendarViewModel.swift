//
//  CalendarViewModel.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/26.
//

import Foundation
import RxSwift
import RxCocoa

final class CalendarViewModel {
    let disposeBag = DisposeBag()
    let writeViewModel = WriteViewModel()
    
    let setDate = PublishSubject<String>()
    
    init() {
    }
}
