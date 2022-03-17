//
//  SearchResult.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/17.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
