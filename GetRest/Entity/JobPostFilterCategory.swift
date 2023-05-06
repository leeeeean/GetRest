//
//  JobPostFilterCategory.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/06.
//

import Foundation

enum Section: String, CaseIterable {
    case 채용형태
    case 희망근무지역
    case 관심분야
    
    var item: [Any] {
        switch self {
        case .채용형태: return RecruitmentType.allCases
        case .희망근무지역: return WorkArea.allCases
        case .관심분야: return Interests.allCases
        }
    }
}

enum RecruitmentType: String, CaseIterable {
    case 경력무관
    case 신입
    case 정규직
    case 계약직
    case 인턴
}

enum WorkArea: String, CaseIterable {
    case 전국
    case 서울
    case 경기
    case 인천
    case 부산
    case 대구
    case 광주
    case 대전
    case 울산
    case 세종
    case 강원
    case 경남
    case 경북
    case 전남
    case 전북
    case 충남
    case 충북
    case 제주
}

enum Interests: String, CaseIterable {
    case 전체
    case 경영·사무
    case 영업·고객상담
    case 디자인
    case IT·인터넷
    case 전문직
    case 서비스
    case 생산·제조
    case 의료
    case 유통·무역
    case 건설
    case 교육
    case 미디어
    case 특수계층·공공
}
