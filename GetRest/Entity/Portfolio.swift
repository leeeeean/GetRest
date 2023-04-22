//
//  Portfolio.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/22.
//

import Foundation


struct Portfolio: Codable{
    let title: String
    let date: String
    
    static let shared = Portfolio(title: "GetRest", date: "2022.12.13 ~ 2230.01.05")
}
