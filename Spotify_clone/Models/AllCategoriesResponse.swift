//
//  AllCategoriesResponse.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/17.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories

}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
    
}

