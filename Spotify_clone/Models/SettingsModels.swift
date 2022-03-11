//
//  SettingsModels.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/11.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
