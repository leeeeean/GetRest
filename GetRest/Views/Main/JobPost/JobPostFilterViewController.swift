//
//  JobPostFilterViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/06.
//

import UIKit

final class JobPostFilterViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 10.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(JobPostFilterViewCollectionViewCell.self, forCellWithReuseIdentifier: JobPostFilterViewCollectionViewCell.identifier)
        collectionView.register(JobPostFilterViewCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JobPostFilterViewCollectionViewHeader.identifier)
        
        return collectionView
    }()
    
    let sectionCategory = Section.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        title = "선택해주세요"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appColor(.baseGreen)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension JobPostFilterViewController: JobPostFilterButtonTappedDelegate {
    func filterButtonTapped(button: UIButton, isSelected: Bool) {
        // selected button data 에 추가... viewModel의 역할인가?
        print("\(button.titleLabel?.text) isSelected \(isSelected)")
    }
}

extension JobPostFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 20.0
        let spaceInterItems = 10.0
        let screenWidth = UIScreen.main.bounds.size.width
        let height = 30.0
        
        switch indexPath.section {
        case 0, 1:
            let width = (screenWidth-inset*2-spaceInterItems*3) / 4
            return CGSize(width: width, height: height)
        case 2:
            let width = (screenWidth-inset*2-spaceInterItems*2) / 3
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension JobPostFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionItem = sectionCategory[section]
        switch sectionItem {
        case .채용형태:
            return (sectionItem.item as? [RecruitmentType])?.count ?? 0
        case .희망근무지역:
            return (sectionItem.item as? [WorkArea])?.count ?? 0
        case .관심분야:
            return (sectionItem.item as? [Interests])?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobPostFilterViewCollectionViewCell.identifier, for: indexPath) as? JobPostFilterViewCollectionViewCell else { return UICollectionViewCell() }
        
        let section = indexPath.section
        let row = indexPath.row
        
        let data: String
        let sectionItem = sectionCategory[section]
        switch sectionItem {
        case .채용형태:
            let category = sectionItem.item as? [RecruitmentType]
            data = category?[row].rawValue ?? ""
        case .희망근무지역:
            let category = sectionItem.item as? [WorkArea]
            data = category?[row].rawValue ?? ""
        case .관심분야:
            let category = sectionItem.item as? [Interests]
            data = category?[row].rawValue ?? ""
        }
        
        cell.delegate = self
        cell.setData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: JobPostFilterViewCollectionViewHeader.identifier,
                for: indexPath
            ) as? JobPostFilterViewCollectionViewHeader else { return UICollectionReusableView() }

            headerView.setData(data: sectionCategory[indexPath.section].rawValue)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}

extension JobPostFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 40.0)
    }
}

