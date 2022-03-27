//
//  LibraryAlbumsResponse.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/27.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
