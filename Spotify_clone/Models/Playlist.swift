//
//  Playlist.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/10.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
