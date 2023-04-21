//
//   MainTabBarController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/17.
//

import UIKit

final class  MainTabBarController: UITabBarController {
    
    let homeViewController = UINavigationController(rootViewController: HomeViewController())
    
    let portfolioViewController = UINavigationController(rootViewController: PortfolioViewController())
    
    let jobPostViewController = UINavigationController(rootViewController: JobPostViewController())
    
    let coverLetterViewController = UINavigationController(rootViewController: CoverLetterViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            homeViewController,
            portfolioViewController,
            jobPostViewController,
            coverLetterViewController
        ]
        
        layout()
    }
    
    private func layout() {
        tabBar.standardAppearance.configureWithOpaqueBackground()
        tabBar.standardAppearance.shadowColor = .clear
        tabBar.standardAppearance.backgroundColor = .white
        
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowOpacity = 0.4
        tabBar.layer.shadowRadius = 6
        tabBar.backgroundColor = .white
        tabBar.tintColor = .appColor(.baseGreen)
        
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        
        homeViewController.tabBarItem = UITabBarItem(
            title:"홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        portfolioViewController.tabBarItem = UITabBarItem(
            title: "포트폴리오",
            image: UIImage(systemName: "list.clipboard"),
            selectedImage: UIImage(systemName: "list.clipboard.fill")
        )
        
        jobPostViewController.tabBarItem = UITabBarItem(
            title: "채용공고",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar")
        )
        
        coverLetterViewController.tabBarItem = UITabBarItem(
            title: "나의 자소서",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill")
        )
    }
}
