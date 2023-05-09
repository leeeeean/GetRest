//
//  PortfolioViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit
import SnapKit

final class PortfolioViewController: UIViewController {
    
    private lazy var categoryTabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PortfolioViewTabBarCollectionViewCell.self, forCellWithReuseIdentifier: PortfolioViewTabBarCollectionViewCell.identifier)
        
        return collectionView
    }()

    private lazy var categoryPageViewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PortfolioViewPageCollectionViewCell.self, forCellWithReuseIdentifier: PortfolioViewPageCollectionViewCell.identifier)
        collectionView.register(PortfolioViewEmptyCollectionViewCell.self, forCellWithReuseIdentifier: PortfolioViewEmptyCollectionViewCell.identifier)
        
        return collectionView
    }()

    let data: [Portfolio]? = Portfolio.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }

    private func layout() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "PortfolioWriteButton"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .appColor(.baseGreen)
        navigationItem.title = "기록작성"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appColor(.baseGreen).cgColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0, weight: .medium)
        ]

        [
            categoryTabBarCollectionView,
            categoryPageViewCollectionView
        ]
            .forEach { view.addSubview($0) }

        categoryTabBarCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(5.0)
            $0.height.equalTo(48.0)
        }
        
        categoryPageViewCollectionView.snp.makeConstraints({
            $0.top.equalTo(categoryTabBarCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }

}

extension PortfolioViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryTabBarCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioViewTabBarCollectionViewCell.identifier, for: indexPath) as? PortfolioViewTabBarCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.row == 0 { cell.changeSelectedColor() }
            
            cell.layout(category: WriteCategory.allCases[indexPath.row].rawValue)
            return cell
        } else {
            guard let emptyDataCell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioViewEmptyCollectionViewCell.identifier, for: indexPath) as? PortfolioViewEmptyCollectionViewCell,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioViewPageCollectionViewCell.identifier, for: indexPath) as? PortfolioViewPageCollectionViewCell else { return UICollectionViewCell() }
            
            emptyDataCell.delegate = self
            cell.delegate = self
            
            if data == nil {
                emptyDataCell.layout()
                return cell
            }
            
            let category = WriteCategory.allCases[indexPath.row]
            let filteredData = data!.filter({ portfolio in
                if category == .전체 {
                    return true
                } else {
                    return portfolio.category == category
                }
            })
            
            if filteredData.count == 0 {
                emptyDataCell.layout()
                return emptyDataCell
            }
            cell.setData(portfolios: filteredData)
            return cell
        }
    }
}

extension PortfolioViewController: TappedTableViewCellDelegate {
    func navigationToReadViewController(portfolio: Portfolio) {
        let vc = ReadViewController(portfolio: portfolio)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PortfolioViewController: TappedEmptyCollectionViewButtonDelegate {
    func writeButtonTapped() {
        let vc = WriteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PortfolioViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryTabBarCollectionView {
            
            for i in 0..<6 {
                let index = IndexPath(row: i, section: 0)
                if let cell = collectionView.cellForItem(at: index) as? PortfolioViewTabBarCollectionViewCell {
                    if index == indexPath { cell.changeSelectedColor() }
                    else { cell.changeNotSelectedColor()}
                }
            }
            categoryTabBarCollectionView.layoutIfNeeded()
            categoryTabBarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            categoryPageViewCollectionView.layoutIfNeeded()
            categoryPageViewCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }


    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if scrollView == categoryPageViewCollectionView {
            let cellWidth = view.frame.width
            let offset = targetContentOffset.pointee
            let index = offset.x / cellWidth
            let roundexIndex = round(index)
            let indexPath = IndexPath(item: Int(roundexIndex), section: 0)
            
            targetContentOffset.pointee = CGPoint(
                x: roundexIndex * cellWidth,
                y: scrollView.contentOffset.y
            )

            categoryTabBarCollectionView.selectItem(
                at: indexPath,
                animated: true,
                scrollPosition: .bottom
            )
            collectionView(categoryTabBarCollectionView, didSelectItemAt: indexPath)
        }
    }
}

extension PortfolioViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryPageViewCollectionView {
            let height = view.safeAreaLayoutGuide.layoutFrame.height - categoryTabBarCollectionView.frame.height
            return CGSize(width: view.frame.width, height: height)
        } else {
            return CGSize(width: 90.0, height: categoryTabBarCollectionView.frame.height)
        }
    }
}
