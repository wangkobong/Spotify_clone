//
//  AppAppearance.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/15.
//

import UIKit

final class AppAppearance {
    static func setupAppearance() {

        // MARK: - NavigationBar
        /// navigationBar 배경 색상
        UINavigationBar.appearance().backgroundColor = .secondarySystemBackground
        /// navigationBar의 버튼 색상 (ex - back 버튼)
        UINavigationBar.appearance().tintColor = .label
        /// navigationBar 중앙에 존재하는 title 색상
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]

        // MARK: - TabBar
        /// TabBar의 버튼 색상 (ex - 탭바 위에 있는 검색 이미지의 색상)
        /// 단, 현재 선택된 ViewController의 tab의 색상과 선택되어 있지 않은 tab의 색상은 자동으로 조정
        UITabBar.appearance().tintColor = .label

        /// TabBar의 background 색상
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
    }
}
