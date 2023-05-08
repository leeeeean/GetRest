//
//  Portfolio.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/22.
//

import UIKit

struct Portfolio: Codable {
    let title: String
    let date: String
    let image: String
    let tag: [String]
    let category: WriteCategory
    
    var getImage: UIImage {
        return UIImage(named: image)!
    }
    
    static let shared = [
        Portfolio(
            title: "GetRest",
            date: "2022.12.13 ~ 2230.01.05",
            image: "PortfolioBackgroundImageEmpty",
            tag: ["동아리", "iOS", "UX/UI 디자인"],
            category: .공모전
        ),
        Portfolio(
            title: "hello",
            date: "2022.12.13 ~ 2230.01.05",
            image: "PortfolioBackgroundImageEmpty",
            tag: ["동아리", "iOS", "AOS"],
            category: .경력사항
        ),
        Portfolio(
            title: "owo",
            date: "2022.12.13 ~ 2230.01.05",
            image: "PortfolioBackgroundImageEmpty",
            tag: ["동아리", "iOS", "AOS"],
            category: .경력사항
        ),
        Portfolio(
            title: "gogosing",
            date: "2022.12.13 ~ 2230.01.05",
            image: "PortfolioBackgroundImageEmpty",
            tag: ["동아리", "iOS", "AOS"],
            category: .경력사항
        ),
        Portfolio(
            title: "starbucks",
            date: "2022.12.13 ~ 2230.01.05",
            image: "PortfolioBackgroundImageEmpty",
            tag: ["동아리", "iOS", "AOS"],
            category: .경력사항
        )
    ]
}
