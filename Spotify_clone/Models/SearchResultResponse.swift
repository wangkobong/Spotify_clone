//
//  SearchResult.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/17.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistResponse
    let tracks: SearchTracksResponse
}

struct SearchAlbumResponse: Codable {
    let items: [Album]
}

struct SearchArtistsResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistResponse: Codable {
    let items: [Playlist]
}


struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
