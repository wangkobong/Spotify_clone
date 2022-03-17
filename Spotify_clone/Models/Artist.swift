//
//  Artist.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/10.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
