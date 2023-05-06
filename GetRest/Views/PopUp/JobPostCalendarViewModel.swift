//
//  JobPostCalendarViewModel.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/06.
//

import Foundation
import RxSwift
import RxCocoa

final class JobPostCalendarViewModel {
    let disposeBag = DisposeBag()
    
    let setDate = PublishSubject<String>()
}
